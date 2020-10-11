
import 'dart:convert';

List<Surveyuuidget> surveyuuidgetFromJson(String str) =>
    List<Surveyuuidget>.from(
        json.decode(str).map((x) => Surveyuuidget.fromJson(x)));

String surveyuuidgetToJson(List<Surveyuuidget> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surveyuuidget {
  Surveyuuidget({
    this.surveyId,
    this.surveyUuiid,
    this.introductiontext,
    this.surveyname,
    this.shortdesc
  });

  String surveyId;
  String surveyUuiid;
  String introductiontext;
  String surveyname;
  String shortdesc;

  factory Surveyuuidget.fromJson(Map<String, dynamic> json) => Surveyuuidget(
      surveyId: json["SurveyId"],
      surveyUuiid: json["SurveyUUIID"],
      introductiontext: json["IntroductionText"],
      surveyname: json["SurveyName"],
      shortdesc: json["ShortDescription"]
  );

  Map<String, dynamic> toJson() => {
    "SurveyId": surveyId,
    "SurveyUUIID": surveyUuiid,
    "IntroductionText": introductiontext,
    "SurveyName": surveyname,
    "ShortDescription": shortdesc
  };
}