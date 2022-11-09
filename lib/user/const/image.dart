import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? file;
  ImagePicker image =ImagePicker();
  @override
  Widget build(BuildContext context) {
    return


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
        );


  }


  getgallery()async{
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file= File(img!.path);
    });
  }


}