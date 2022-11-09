import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          User(name: 'amit',imageurl: ' backgroundColor: Colors.cyan[100],',),
        ],
      ),
    ));
  }
}

class User extends StatelessWidget {
  final String name;
  final imageurl;
  User({required this.name,required this.imageurl});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.cyan[100],
          backgroundImage: NetworkImage(imageurl),
        ),
        Text(name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),)
      ],
    );
  }
}
