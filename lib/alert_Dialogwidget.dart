import 'dart:ui';
import 'package:flutter/material.dart';


class BlurryDialog extends StatelessWidget {

  String title;
  String content;

  BlurryDialog(this.title, this.content);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(10)),
          ),
          title: new Text(title,style: textStyle,),
          content: new Text(content, style: textStyle,),
          actions: <Widget>[
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              child: RaisedButton(
                  color: Colors.lightBlue[900],
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
              ),
            )
          ],
        ));
  }
}