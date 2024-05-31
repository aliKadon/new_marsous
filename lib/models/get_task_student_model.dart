import 'package:marsous1/models/session_model.dart';

class GetTaskStudentModel {
  List<SessionModel>? oldTasks;
  List<SessionModel>? upCommingTasks;

  GetTaskStudentModel({
    this.oldTasks,
    this.upCommingTasks,
  });

  factory GetTaskStudentModel.fromJson(Map<String, dynamic> json) =>
      GetTaskStudentModel(
        oldTasks: List<SessionModel>.from(
          json["oldTasks"].map(
            (x) => SessionModel.fromJson(x),
          ),
        ),
        upCommingTasks: List<SessionModel>.from(
          json["upCommingTasks"].map(
            (x) => SessionModel.fromJson(x),
          ),
        ),
      );
}
