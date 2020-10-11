import 'dart:convert';

List<GetDescription> getdescriptionFromJson(String str) =>
    List<GetDescription>.from(
        json.decode(str).map((x) => GetDescription.fromJson(x)));

String getdescriptionToJson(List<GetDescription> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class GetDescription {

  String surveyId;
  String surveyName;
  String introductionText;

  GetDescription({
    this.surveyId,
    this.surveyName,
    this.introductionText,
  });

  factory GetDescription.fromJson(Map<String, dynamic> json) => GetDescription(
    surveyId: json["SurveyId"],
    introductionText: json["IntroductionText"],
  );

  Map<String, dynamic> toJson() => {
    "SurveyId": surveyId,
    "IntroductionText": introductionText,
  };


}