import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final keyboardtype;

  Field({ required this.hintText,
    this.validator, this.inputFormatters,this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: new Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      margin: EdgeInsets.all(20),
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration:  InputDecoration(
          hintText: hintText,


        ),
        validator: validator,
        keyboardType: TextInputType.phone,

      ),
    );
  }
}