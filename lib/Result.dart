import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Home.dart';

class resultpage extends StatefulWidget{

  var completemsg;

  resultpage(this.completemsg);

  @override
  _resultpageState createState() => _resultpageState(completemsg);
}

class _resultpageState extends State<resultpage> {


  var completemsg;

  _resultpageState(this.completemsg);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              elevation: 10,
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 5.0,
                        child: Container(
                          width: 300,
                          height: 300,
                          child: ClipRect(
                            child: Image(
                                image: AssetImage('images/OET-survey-small.png')
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 15.0
                        ),
                        child: Center(
                          child: Text(
                             completemsg ,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: "Quando"
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen()
                  ));
                },
                  child: Text(
                    "Start New Survey",
                    style: TextStyle(
                        fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0
                  ),
                  color: Colors.lightBlue[900],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}