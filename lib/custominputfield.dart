import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget{

  String hinttext;

  CustomInputField(this.hinttext);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 250,
      child: Material(
        elevation: 5,
        color: Colors.deepOrange,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hinttext
          ),
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),
        ),
      ),
    );
  }

}