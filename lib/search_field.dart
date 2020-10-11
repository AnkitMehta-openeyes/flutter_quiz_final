import 'package:flutter/material.dart';

class SearchField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10
          ),
          hintText: "Enter Survey ID",
          suffixIcon: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            child: Icon(
                Icons.search,
              color: Colors.lightBlue[900],
            ),
          ),
          border: InputBorder.none
        ),
      ),
    );
  }

}