
import 'package:flutter/material.dart';

import 'add_student.dart';
import 'list_student_page.dart';



class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudentPage()));},
            child: Text('screen1',style: TextStyle(color: Colors.white),),


          ),
          TextButton(
            onPressed: (){},
            child: Text('screen2',style: TextStyle(color: Colors.white),),


          ),
        ],
      ),
    );
  }
}