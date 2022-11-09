import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinehouse/pages/update_student.dart';

import 'add_student.dart';

class ListStudentPage extends StatefulWidget {

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {

  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

  CollectionReference students = FirebaseFirestore.instance.collection('students');

   Future<void> deleteUser(id){
      // print('User deleted $id');
     return students.doc(id).delete().then((value) => print('user deleted')).
     catchError((error)=>print('failed to delete this error :$error'));
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>( stream: studentsStream ,
        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot>
        snapshot){
      if(snapshot.hasError){
        print('Something wrong');
      }if(snapshot.connectionState == ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      }


      final List storedocs =[];
      snapshot.data!.docs.map((DocumentSnapshot document) {
       Map a= document.data() as Map< String,dynamic> ;
       storedocs.add(a);
       a['id'] = document.id;
      }).toList();

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(

            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>AddStudentPage()));
                },
                child: Text('Add employes'),
              ),

              for(var i=0; i<storedocs.length ; i++)...[
                

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(storedocs[i]['images']),
                      // child: images,
                    ),
                    Container(
                      child: Center(
                        child: Text(storedocs[i]['name'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                    // Container(
                    //   color: Colors.greenAccent,
                    //   child: Center(
                    //     child: Text(
                    //       storedocs[i]['email'],
                    //       style: TextStyle(fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                     Row(

                      children: [
                        IconButton(onPressed:(){
                          Navigator.push(context,
                              MaterialPageRoute
                                (builder:
                                  (context)=>
                                  UpdateStudentPage(
                                   id: storedocs[i]['id']
                                  )));
                        } ,
                            icon: Icon(Icons.edit)),
                        IconButton(onPressed:()=>{deleteUser(storedocs[i]['id'])},
                            icon: Icon(Icons.delete))
                      ],
                    ),

                  ]
              ),
                      ],


            ],
          ),
        ),
      );
        });

  }
}

