import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_final/splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(FlutterQuiz());
}

class FlutterQuiz extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OpenEyes Survey",
      theme: ThemeData(
          primarySwatch: Colors.indigo
      ),
      home: SplashScreen(),
    );
  }

}

