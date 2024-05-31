import 'package:get/get.dart';

class TaskTestModel  extends GetxController{
  String? id;
  String? file;
  String? question;
  String? couseName;
  bool? isAvilableForEvaluating;
  String? date;

  TaskTestModel({
    this.id,
    this.couseName,
    this.file,
    this.isAvilableForEvaluating,
    this.question,
    this.date,
  });

  factory TaskTestModel.fromJson(Map<String, dynamic> json) => TaskTestModel(
        couseName: json["couseName"],
        file: json["file"],
        id: json["id"],
        isAvilableForEvaluating: json["isAvilableForEvaluating"],
        question: json["question"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "question": question,
        "couseName": couseName,
        "isAvilableForEvaluating": isAvilableForEvaluating,
        "date": date,
      };
}
