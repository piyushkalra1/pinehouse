import 'package:flutter/material.dart';
import 'package:pinehouse/pages/add_student.dart';
import 'package:pinehouse/pages/navbar.dart';

import 'list_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Screen1',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
      body: ListStudentPage(),
    );
  }
}



