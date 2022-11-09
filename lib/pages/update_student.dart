
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinehouse/pages/navbar.dart';
import 'add_student.dart';

class UpdateStudentPage extends StatefulWidget {

  final String id;
  const UpdateStudentPage({Key? key,required this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {

  final _formKey = GlobalKey<FormState>();

  updateUser() {
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            'SCREEN 3',style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: FirebaseFirestore.instance.collection
          ('students').doc(widget.id ).get(),
        builder: (_,snapshot){
          if(snapshot.hasError){
            print('something went wrong');
          }if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          var data = snapshot.data!.data();
          var name = data!['name'];
          var email = data['email'];
          var password = data['password'];
          var images = data['images'];
          var department= data['department'];
          return  Center(
            child: Column(
              children: [

                CircleAvatar(
                  radius: 140,
                  backgroundImage: NetworkImage(images),
                  // child: images,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30,),

                Center(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'phone : '
                      ),
                      Text(
                       email
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Age :'
                    ),
                    Text(
                     password
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'department :'
                    ),
                    Text(
                        department
                    ),
                  ],
                ),

              ],
            ),
          );

        },
      ),
    );
  }
}
