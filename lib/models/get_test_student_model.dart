import 'package:marsous1/models/session_model.dart';

class GetTestStudentModel {
  List<SessionModel>? oldTests;
  List<SessionModel>? upCommingTests;

  GetTestStudentModel({
    this.oldTests,
    this.upCommingTests,
  });

  factory GetTestStudentModel.fromJson(Map<String, dynamic> json) =>
      GetTestStudentModel(
        oldTests: List<SessionModel>.from(
          json["oldTests"].map(
                (x) => SessionModel.fromJson(x),
          ),
        ),
        upCommingTests: List<SessionModel>.from(
          json["upCommingTests"].map(
                (x) => SessionModel.fromJson(x),
          ),
        ),
      );
}