
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinehouse/user/second.dart';
import 'const/customform.dart';
import 'package:pinehouse/pages/dropdown.dart';

import 'const/image.dart';
class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}


class _FirstState extends State<First> {



  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController =TextEditingController();
  TextEditingController nameController =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Field(hintText: 'phone number',inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                ),
              ],validator: (val) {
                if (val!.length !=10)
                  return 'Enter valid phone number';
              },
              ),

              Field(hintText: 'Name',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z]+|\s"),
                  )
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }

                },),
              Field(hintText: 'your age',inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                ),
              ],validator: (val) {
                if (val==null || val.length>2)
                  return 'Enter valid age';
              },


              ),
              DropdownButtonExample(),
              MyApp(),



              ElevatedButton(
                onPressed: () {
                   {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Second(),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              )

            ],
          ),
        ),
      ) ,
    ));
  }


}






