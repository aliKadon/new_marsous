import 'package:get/get.dart';

class TestStudentModel extends GetxController{
  String? id;
  String? couseName;
  String? file;
  String? question;
  String? studentId;
  String? fullName;
  String? testAnswer;
  String? testSubmissionDate;
  int? grade;

  TestStudentModel({
    this.question,
    this.file,
    this.couseName,
    this.id,
    this.fullName,
    this.studentId,
    this.testAnswer,
    this.testSubmissionDate,
    this.grade,
  });

  void updateGrade({required int gradeUpdated}) {
    grade = gradeUpdated;
    update();
  }

  factory TestStudentModel.fromJson(Map<String, dynamic> json) =>
      TestStudentModel(
        question: json["question"],
        id: json["id"],
        file: json["file"],
        couseName: json["couseName"],
        fullName: json["fullName"],
        studentId: json["studentId"],
        testAnswer: json["testAnswer"],
        testSubmissionDate: json["testSubmissionDate"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "couseName": couseName,
        "file": file,
        "question": question,
        "studentId": studentId,
        "fullName": fullName,
        "testAnswer": testAnswer,
        "testSubmissionDate": testSubmissionDate,
        "grade": grade,
      };
}
