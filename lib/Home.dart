import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_final/questioncolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'DescriptionPage.dart';
import 'Getuuidfile.dart';
import 'Result.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'alert_Dialogwidget.dart';
import 'custominputfield.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final surveyidcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rememberMe = false;

  List suggestionlist = [
    "612020",
    "622020",
    "632020",
    "642020",
    "652020",
    "662020",
    "123456 - HRCI Survey"
  ];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      key: _scaffoldKey,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blue,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                color: Color.fromRGBO(255,255,255,0.4),
                child: Container(
                  width: 450,
                  height: 450,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('images/OET-survey-small.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
//                   CustomInputField('Enter the survey ID'),
                    Container(
                      width: 300,
                      child: AutoCompleteTextField(
                        controller: surveyidcontroller,
                        clearOnSubmit: false,
                        suggestions: suggestionlist,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          hintText: "Search Surveys by Name or ID",
                          suffixIcon: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(
                              Icons.search,
                              color: Colors.lightBlue[900],
                            ),
                          ),
                        ),
                        itemFilter: (item, query){
                          return item.toLowerCase().startsWith(query.toLowerCase());
                        },
                        itemSorter: (a,b){
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item){
                          surveyidcontroller.text = item;
                        },
                        itemBuilder: (context, item){
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            child : Row(
                              children: [
                                Text(item)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    CheckboxListTile(
                      title: Text("I agree to the terms and conditions."),
                      value: rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          rememberMe = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),
                    RaisedButton(onPressed: GetSurvey,
                      color: Colors.lightBlue[900],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Text('Submit',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context){
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

  Future GetSurvey() async {

    var txtfieldresponse = surveyidcontroller.text;
    var apisurveyid;
    var surveyID;
    var description;

    if(rememberMe == true) {
      if(txtfieldresponse.isNotEmpty){
        showAlertDialog(context);
        if (txtfieldresponse == suggestionlist[0]) {
          apisurveyid = "1";
          surveyID = "612020";
        }
        else if (txtfieldresponse == suggestionlist[1]) {
          apisurveyid = "2";
          surveyID = "622020";
        }
        else if (txtfieldresponse == suggestionlist[2]) {
          apisurveyid = "3";
          surveyID = "632020";
        }
        else if (txtfieldresponse == suggestionlist[3]) {
          apisurveyid = "4";
          surveyID = "642020";
        }
        else if (txtfieldresponse == suggestionlist[4]) {
          apisurveyid = "5";
          surveyID = "652020";
        }
        else if (txtfieldresponse == suggestionlist[5]) {
          apisurveyid = "6";
          surveyID = "662020";
        }
        var response = await http.get(
            "https://openeyessurveys.com/api/Survey/getAllSurveys",
            headers: {
              "Accept": "application/json"
            }
        );
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.

          List<Surveyuuidget> surveyuuidgetList = surveyuuidgetFromJson(
              response.body);
          for (int i = 0; i < surveyuuidgetList.length; i++) {
            if (surveyuuidgetList[i].surveyId == apisurveyid) {
              var surveyuuid = surveyuuidgetList[i].surveyUuiid;
              description = surveyuuidgetList[i].introductiontext;
              var shortdesc = surveyuuidgetList[i].shortdesc;
              var surveyname = surveyuuidgetList[i].surveyname;
              print(surveyuuidgetList[i].surveyId);
              final document = parse(shortdesc);
              final String parsedString = parse(document.body.text)
                  .documentElement.text;
              print(parsedString);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  DescPage(parsedString, surveyID, surveyname)));
            }
          }
        }
        else {
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
      else{
        BlurryDialog  alert = BlurryDialog("Error","Please enter the survey ID");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return alert;
          },
        );
      }
    }
    else{
      BlurryDialog  alert = BlurryDialog("Error","Please check the checkbox");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return alert;
        },
      );
    }



    /*if(isNumeric(txtfieldresponse) == true){
      if(rememberMe == true){
        showAlertDialog(context);
        switch(txtfieldresponse){
          case "612020":
            apisurveyid = "1";
            break;
          case "622020":
            apisurveyid = "2";
            break;
          case "632020":
            apisurveyid = "3";
            break;
          case "642020":
            apisurveyid = "4";
            break;
          case "652020":
            apisurveyid = "5";
            break;
          case "662020":
            apisurveyid = "6";
            break;
        }
        var response = await http.get(
            "https://openeyessurveys.com/api/Survey/getAllSurveys",
            headers: {
              "Accept": "application/json"
            }
        );
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.

          List<Surveyuuidget> surveyuuidgetList = surveyuuidgetFromJson(response.body);
          for (int i = 0; i < surveyuuidgetList.length; i++) {
            if (surveyuuidgetList[i].surveyId == apisurveyid) {
              var surveyuuid = surveyuuidgetList[i].surveyUuiid;
              description = surveyuuidgetList[i].introductiontext;
              var shortdesc = surveyuuidgetList[i].shortdesc;
              var surveyname = surveyuuidgetList[i].surveyname;
              print(surveyuuidgetList[i].surveyId);
              final document = parse(shortdesc);
              final String parsedString = parse(document.body.text).documentElement.text;
              print(parsedString);
              Navigator.push(context, MaterialPageRoute(builder: (context) => DescPage(parsedString,surveyidcontroller.text,surveyname)));
              *//*var response1 = await http.get(
                  "https://openeyessurveys.com/api/Survey/getSurveyDetails/" + surveyuuid,
                  headers: {
                    "Accept": "application/json"
                  }
              );

              if(response1.statusCode == 200){
                //Map<String, dynamic> map1 = json.decode(response.body);
                List<GetDescription> getDescription =  getdescriptionFromJson(response1.body);
                description = getDescription[i].introductionText;
                print(description);

                Navigator.push(context, MaterialPageRoute(builder: (context) => DescPage(description,surveyidcontroller.text)));

              }else {
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
              }*//*
              *//*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DescPage(surveyuuidgetList[i])));*//*
            }
          }

          *//*Map<String, dynamic> map = json.decode(response.body);
          //var data = map['Item'];
          Surveyuuidget surveyuuidget = new Surveyuuidget.fromjson(map);
          if(surveyuuidget.surveyid == apisurveyid){

            var surveyuuid = surveyuuidget.surveyuuid;

            var response1 = await http.get(
                "https://openeyessurveys.com/api/Survey/getSurveyDetails/" + surveyuuid,
                headers: {
                  "Accept": "application/json"
                }
            );

            if(response1.statusCode == 200){
              Map<String, dynamic> map1 = json.decode(response.body);
              GetDescription getDescription =  GetDescription.fromJson(map1);
              description = getDescription.introductionText;
              print(description);

              Navigator.push(context, MaterialPageRoute(builder: (context) => DescPage(description,surveyidcontroller.text)));

            }

          }*//*

          //Navigator.push(context, MaterialPageRoute(builder: (context) => quizpage(newquestions)));

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
      else{
        BlurryDialog  alert = BlurryDialog("Error","Please check the checkbox");


        showDialog(
          context: context,
          builder: (BuildContext context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return alert;
          },
        );
      }
    }
    else{
      BlurryDialog  alert = BlurryDialog("Error","Please enter a numeric survey ID?");


      showDialog(
        context: context,
        builder: (BuildContext context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return alert;
        },
      );
    }
*/

  }
}

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}


class Questions{
  String questions;

  Questions({this.questions});

  factory Questions.fromjson(Map<String, dynamic> json){


    //var questionfromjson = json['question'];
    //List<String> questionslist = new List<String>.from(questionfromjson);

    return Questions(
        questions: json['question']
    );
  }

  @override
  String toString() {
    //return 'questions{questions: $questions}';
    return questions;
  }

}


class Survey{
  String surveyid;
  //String desc;
  String completemsg;
  List<Questions> questions;

  Survey({this.surveyid,this.completemsg,this.questions});

  factory Survey.fromjson(Map<String, dynamic> json){

    var list = json['QUESTIONS'] as List;
    print(list.runtimeType);

    List<Questions> questionslist = list.map((e) => Questions.fromjson(e)).toList();

    return Survey(
        surveyid: json['OS_ID'],
        completemsg: json['COMPLETE_MESSAGE'],
        questions: questionslist,
    );
  }
}





class quizpage extends StatefulWidget{

  var questions,surveyid,completemsg;

  quizpage(this.questions,this.surveyid,this.completemsg);

  //quizpage({Key key, @required this.questions}) : super(key : key);

  @override
  _quizpageState createState() => _quizpageState(questions,surveyid,completemsg);
}

class _quizpageState extends State<quizpage> with SingleTickerProviderStateMixin {

  var questions,surveyid,completemsg;




  _quizpageState(this.questions,this.surveyid,this.completemsg);

  int i = 0;

  int flag = 0;
  int counter = 0;
  int length;
  bool isenabled;
  bool count = false;



  Map<String, Color> btncolor = {
    "1" : Colors.grey,
    "2" : Colors.grey,
    "3" : Colors.grey,
    "4" : Colors.grey,
    "5" : Colors.grey,
    "6" : Colors.grey,
    "7" : Colors.grey,
    "8" : Colors.grey,
    "9" : Colors.grey,
  };



  final answercontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    SizeConfig().init(context);
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(
                      "OpenEyes Survey"
                  ),
                  content: Text(
                      "You cannot go back at this stage"
                  ),
                  actions: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                            "OK"
                        ),
                        color: Colors.lightBlue[900],
                      ),
                    )
                  ],
                )
        );
      },
      child: Scaffold(
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
        //backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('images/OET-survey-small.png',
                  width: 40,
                  height: 40,
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 85,
                        ),
                        CalculatePercentage(),
                        SizedBox(
                          width: 50,
                        ),
                        QuestionColor()
                      ],
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Numberofquestion()
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Center(
                      child: Container(
                        width: 400,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: 250,
                              child: Material(
                                elevation: 5,
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                                child: TextField(
                                  enabled: false,
                                  maxLines: 6,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: questions[i]
                                  ),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Container(
                            width: 300,
                            height: 300,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 250,
                                    child: Material(
                                      elevation: 2,
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: TextField(
                                        controller: answercontroller,
                                        maxLines: 1,
                                        //enabled: false,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Answer'
                                        ),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                        )
                    )
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 60,
                                child: RaisedButton(onPressed: isenabled ? null : PreviousQuestion,
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Text('Previous',
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              RaisedButton(onPressed: SkipQuestion,
                                color: Colors.deepOrange,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text('Skip',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              RaisedButton(onPressed: NextQuestion,
                                color: Colors.green,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text('Next',
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Align(
                                child: endbutton(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void setState(fn) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement setState
    super.setState(fn);
    if(btncolor[(i+1).toString()] == Colors.deepOrange){
      btncolor[(i+1).toString()] = Colors.purple;
      flag = 1;
    }
    else if(btncolor[(i+1).toString()] == Colors.green){
      btncolor[(i+1).toString()] = Colors.purple;
      flag = 2;
    }
    else{
      btncolor[(i+1).toString()] = Colors.purple;
    }

    if(i == 0){
      isenabled = true;
    }
    else{
      isenabled = false;
    }

  }

  void NextQuestion() {
    if(answercontroller.text.length == 0){
      BlurryDialog  alert = BlurryDialog("Error","Please enter an answer");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    else{
      setState(() {
        if(i < (questions.length - 1)){
          // ignore: unnecessary_statements
          btncolor[(i+1).toString()] = Colors.green;
          i++;
        }
        else{
          var temp = 0;
          for(int k=0;k<questions.length; k++){
            if(btncolor[(k+1).toString()] == Colors.green){
              temp++;
            }
          }
          if(temp == 8){
            count = true;
          }
          BlurryDialog  alert = BlurryDialog("Alert","Please click on the submit button to end the survey");
          showDialog(
            context: context,
            builder: (BuildContext context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return alert;
            },
          );
          /*
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => resultpage(),
            ));*/
        }
      });

    }

  }


  @override
  void initState() {
    super.initState();
    isenabled = false;
    btncolor[(i+1).toString()] = Colors.purple;
    if(i == 0){
      isenabled = true;
    }
    else{
      isenabled = false;
    }
  }

  void SkipQuestion() {
    setState(() {
      if(i < (questions.length - 1)){
        // ignore: unnecessary_statements
        btncolor[(i+1).toString()] = Colors.deepOrange;
        i++;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(surveyid),
        ));
      }
    });
  }



  void ChooseQuestion() {
    setState(() {
      if(i < (questions.length)){
        for(int k =0; k< (questions.length); k++){
          if(k != i){
            if(btncolor[(k+1).toString()] == Colors.purple){
              if(flag == 1){
                btncolor[(k+1).toString()] = Colors.red;
                flag =0;
              }
              else if(flag == 2){
                btncolor[(k+1).toString()] = Colors.green;
                flag =0;
              }
              else{
                btncolor[(k+1).toString()] = Colors.grey;
              }

            }
          }
          else{
            if(btncolor[(k+1).toString()] == Colors.purple){
              if(flag == 1){
                btncolor[(k+1).toString()] = Colors.red;
              }
              else if(flag == 2){
                btncolor[(k+1).toString()] = Colors.green;
                flag =0;
              }
              else{
                btncolor[(k+1).toString()] = Colors.grey;
              }
            }
          }
        }
        //i++;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(surveyid),
        ));
      }
    });
  }

  /*Widget choicebutton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0
      ),
      child: MaterialButton(onPressed: null,
        child: Text((i+1).toString(),
        style: TextStyle(
            color: Colors.white,
          fontFamily: "Alike",
          fontSize: 16.0
          ),
        ),
        color: Colors.deepOrangeAccent,
        splashColor: Colors.deepOrange[700],
        highlightColor: Colors.deepOrange[700],
      ),
    );
  }*/

  void EndSurvey() async {
    if(count == true){
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Alert'),
          content: Text(
              'Are you sure you want to end the survey?'),
          actions: <Widget>[
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => resultpage(completemsg),
                      ));
                    },
                    color: Colors.lightBlue[900],
                    child: new Text('Yes',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new RaisedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    color: Colors.lightBlue[900],
                    child: new Text('No',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    else{
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Alert'),
          content: Text(
              'You have not answered ' + (questions.length - counter).toString() + ' questions. Are you sure you want to end the survey?'),
          actions: <Widget>[
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => resultpage(completemsg),
                      ));
                    },
                    color: Colors.blue,
                    child: new Text('Yes'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new RaisedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    color: Colors.blue,
                    child: new Text('No'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  void PreviousQuestion() {
    if(answercontroller.text.length == 0){
      BlurryDialog  alert = BlurryDialog("Error","Please enter an answer");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return alert;
        },
      );
    }
    else{
      if(i == 0){
        // ignore: unnecessary_statements
        setState(() {
          BlurryDialog  alert = BlurryDialog("Error","There are no previous questions");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return alert;
            },
          );
        });
      }
      else{
        btncolor[(i+1).toString()] = Colors.green;
        flag = 0;
        i--;
      }
    }
  }

  Widget Numberofquestion() {
    if(questions.length == 9){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 0;
              ChooseQuestion();
            },
              color: btncolor["1"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text("1",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 1;
              ChooseQuestion();
            },
              color: btncolor["2"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('2',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 2;
              ChooseQuestion();
            },
              color: btncolor["3"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 3;
              ChooseQuestion();
            },
              color: btncolor["4"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('4',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 4;
              ChooseQuestion();
            },
              color: btncolor["5"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('5',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 5;
              ChooseQuestion();
            },
              color: btncolor["6"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('6',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 6;
              ChooseQuestion();
            },
              color: btncolor["7"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('7',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 7;
              ChooseQuestion();
            },
              color: btncolor["8"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('8',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: RaisedButton(onPressed: () {
              i = 8;
              ChooseQuestion();
            },
              color: btncolor["9"],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
              child: Text('9',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  CalculatePercentage() {
    length = questions.length;
    counter = 0;
    for(int k=0;k<questions.length; k++){
      if(btncolor[(k+1).toString()] == Colors.green){
        counter++;
      }
    }
    if(counter == 0){
      return CircularPercentIndicator(
        progressColor: Colors.blue,
        percent: 0,
        animation: true,
        radius: 70.0,
        lineWidth: 8.0,
        center: Text("0%"),
      );
    }
    else{
      return CircularPercentIndicator(
        progressColor: Colors.blue,
        percent: (counter/length),
        animation: true,
        radius: 70.0,
        lineWidth: 8.0,
        center: Text(((counter/length)*100).round().toString() + "%"),
      );
    }
  }

  endbutton() {
    if(i == 8){
        return ButtonTheme(
          minWidth: 200,
          child: RaisedButton(onPressed: EndSurvey,
            color: Colors.lightBlue[900],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0))),
            child: Text('Submit',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
        );
    }
    else{
        return ButtonTheme(
          minWidth: 200,
          child: RaisedButton(onPressed: EndSurvey,
            color: Colors.red,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0))),
            child: Text('End',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
        );
    }
  }
}


class SizeConfig {

  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;
    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;
  }
}

