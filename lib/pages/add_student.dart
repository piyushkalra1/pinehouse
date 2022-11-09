
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinehouse/pages/navbar.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey =GlobalKey<FormState>();

   Future getgallery()async{
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file= File(img!.path);
    });
  }

  Future uploadImage(File _image) async{
     String url;
     String imgId = DateTime.now().microsecondsSinceEpoch.toString() ;
    Reference reference = FirebaseStorage.instance.ref().child('/images').child('user$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  var name="";
  var number ="";
  var age ="";
  var dapartment = "";

  final nameController =TextEditingController();
  final numberController =TextEditingController();
  final ageController =TextEditingController();
  final departmentContoller =TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    ageController.dispose();
    departmentContoller.dispose();
    super.dispose();
  }
  clearText(){
    nameController.clear();
    numberController.clear();
    ageController.clear();
    departmentContoller.clear();
  }



  CollectionReference students = FirebaseFirestore.instance.collection('students');

  Future<void> addUser()async{
    final  imageUrl =await uploadImage(file!);
    return students.add({'name': name, 'email': number , 'password':age,'department': dapartment,
      'images': imageUrl,
    })
        .then((value) => print('user added')).
    catchError((error)=>print('failed to add user this error :$error'));
  }
  File? file;
  ImagePicker image =ImagePicker();
  String ?downloadUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text('screen1',style: TextStyle(color: Colors.black),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Column(
          children: [
          Container(
          height: 140,
            width: 180,
            color: Colors.black12,
            child: file==null?Icon(Icons.image,
              size: 60,):Image.file(file!,fit: BoxFit.fill,),
          ),
          MaterialButton(onPressed: (){
            getgallery();
          },
            color: Colors.black12,
            child: Text('choose from gallery',style: TextStyle(
              color: Colors.white,
            ),),),
          ],
        ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),

              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'department: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: departmentContoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter deep';
                    }
                    return null;
                  },
                ),

              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'phone ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: numberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (value.length!=10) {
                      return 'Please Enter Valid number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'age: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter age';
                    }if(value.length>=3){
                      return 'Please Enter valid age';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            number = numberController.text;
                            age = ageController.text;
                            dapartment=departmentContoller.text;
                            addUser();
                            clearText();

                          });

                        }

                      },
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


