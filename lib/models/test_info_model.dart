class TestInfoModel {
  String? id;
  String? courseId;
  String? lessonTest;
  String? testFilePath;
  String? centerName;
  String? testAnswer;
  String? date;
  bool? isSessionToday;
  String? courseName;
  bool? scheduled;
  int? testGrade;
  int? attendance;
  String? attendanceAsString;

  TestInfoModel({
    this.id,
    this.date,
    this.courseId,
    this.attendanceAsString,
    this.attendance,
    this.centerName,
    this.courseName,
    this.isSessionToday,
    this.lessonTest,
    this.scheduled,
    this.testAnswer,
    this.testFilePath,
    this.testGrade,
  });

  factory TestInfoModel.fromJson(Map<String, dynamic> json) => TestInfoModel(
        id: json["id"],
        date: json["date"],
        courseId: json["courseId"],
        attendance: json["attendance"],
        attendanceAsString: json["attendanceAsString"],
        centerName: json["centerName"],
        courseName: json["courseName"],
        isSessionToday: json["isSessionToday"],
        lessonTest: json["lessonTest"],
        scheduled: json["scheduled"],
        testAnswer: json["testAnswer"],
        testFilePath: json["testFilePath"],
        testGrade: json["testGrade"],
      );
}
