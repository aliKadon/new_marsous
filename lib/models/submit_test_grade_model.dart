class SubmitTestGradeModel {
  String? sessionId;
  int? testGrade;

  SubmitTestGradeModel({this.testGrade, this.sessionId});

  // final SessionModel sessionModel = Get.find<SessionModel>();
  //
  // void updateGradeTest() {
  //   sessionModel.testGrade = testGrade;
  //   update();
  // }

  factory SubmitTestGradeModel.fromJson(Map<String, dynamic> json) =>
      SubmitTestGradeModel(
        sessionId: json["sessionId"],
        testGrade: json["testGrade"],
      );

  Map<String, dynamic> toJson() => {
    "SessionId": sessionId,
    "testGrade": testGrade,
  };
}