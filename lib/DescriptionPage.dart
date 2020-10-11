import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'descriptionget.dart';
import 'Home.dart';
import 'alert_Dialogwidget.dart';

class DescPage extends StatefulWidget{

  var description;
  var surveyid;
  var surveyname;

  DescPage(this.description,this.surveyid,this.surveyname);


  @override
  _DescPageState createState() => _DescPageState(description,surveyid,surveyname);
}

class _DescPageState extends State<DescPage> {

  var description,surveyid,surveyname;



  _DescPageState(this.description,this.surveyid,this.surveyname);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    // TODO: implement build
    return Scaffold(
        persistentFooterButtons: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                  child: Text('Privacy Policy'),
                  onTap: () => launch('https://www.openeyessurveys.com/privacy-policy')
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                      thickness: 1,
                      color: Colors.black
                  )
              ),
              SizedBox(width: 3,),
              InkWell(
                  child: Text('Terms of Use'),
                  onTap: () => launch('https://www.openeyessurveys.com/terms-of-use')
              ),
            ],
          ),
          Text('© 2020 & powered by OpenEyes Technologies Inc.'),
        ],
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('images/OET-survey-small.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 210,
                      ),
                      Image.asset('images/rp-logo.png',
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(surveyname,
                    style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontSize: 20,
                        fontFamily: 'Alike',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(description,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Alike',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(onPressed: PreviousScreen,
                    color: Colors.lightBlue[900],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Text('Change Survey ID',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  RaisedButton(onPressed: NextQuestion,
                    color: Colors.lightBlue[900],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Text('Start Survey',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }


  Future GetSurvey() async {
    showAlertDialog(context);
    var txtfieldresponse = surveyid;
    var response = await http.get(
        "http://openeyessurvey.com/api/get_open_survey_info/" + txtfieldresponse,
        headers: {
          "Accept": "application/json"
        }
    );
    if (response.statusCode == 200) {
      showAlertDialog(context);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> map = json.decode(response.body);
      var data = map['Item'];
      Survey survey = new Survey.fromjson(data);
      var msg = survey.completemsg;
      print(msg);
      //String description = survey.desc;
      List<String> newquestions = [];
      for(int i=0; i<survey.questions.length; i++){
        newquestions.add(survey.questions[i].toString()) ;
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => quizpage(newquestions,surveyname,msg)));
      //Navigator.push(context, MaterialPageRoute(builder: (context) => quizpage(newquestions)));
      print(newquestions.length);
      print(newquestions);
    } else {
      BlurryDialog  alert = BlurryDialog("Error","This is not a valid survey ID");


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Hello');
      throw Exception('Please enter a valid survey ID');
    }


  }



  void PreviousScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void NextQuestion() {
    GetSurvey();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => quizpage(questions,surveyid)));
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

