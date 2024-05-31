class SubmitGradeTaskModel {
  String? sessionId;
  int? taskGrade;

  SubmitGradeTaskModel({this.taskGrade, this.sessionId});

  // final SessionModel sessionModel = Get.find<SessionModel>();
  //
  // void updateGradeTest() {
  //   sessionModel.testGrade = testGrade;
  //   update();
  // }

  factory SubmitGradeTaskModel.fromJson(Map<String, dynamic> json) =>
      SubmitGradeTaskModel(
        sessionId: json["sessionId"],
        taskGrade: json["taskGrade"],
      );

  Map<String, dynamic> toJson() => {
        "SessionId": sessionId,
        "TaskGrade": taskGrade,
      };
}
