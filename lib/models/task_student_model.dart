import 'package:get/get.dart';

class TaskStudentModel extends GetxController {
  String? id;
  String? couseName;
  String? file;
  String? question;
  String? studentId;
  String? fullName;
  String? taskAnswer;
  String? taskSubmissionDate;
  int? grade;

  TaskStudentModel({
    this.question,
    this.file,
    this.couseName,
    this.id,
    this.fullName,
    this.studentId,
    this.taskAnswer,
    this.taskSubmissionDate,
    this.grade,
  });

  void gradeUpdated({required int gradeUpdated}) {
    grade = gradeUpdated;
    update();
  }

  factory TaskStudentModel.fromJson(Map<String, dynamic> json) =>
      TaskStudentModel(
        question: json["question"],
        id: json["id"],
        file: json["file"],
        couseName: json["couseName"],
        fullName: json["fullName"],
        studentId: json["studentId"],
        taskAnswer: json["taskAnswer"],
        taskSubmissionDate: json["taskSubmissionDate"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "couseName": couseName,
        "file": file,
        "question": question,
        "studentId": studentId,
        "fullName": fullName,
        "taskAnswer": taskAnswer,
        "taskSubmissionDate": taskSubmissionDate,
        "grade": grade,
      };
}
