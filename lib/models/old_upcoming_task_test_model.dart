import 'package:marsous1/models/task_test_model.dart';

class OldUpcomingTaskTestModel {
  List<TaskTestModel>? old;
  List<TaskTestModel>? upcomming;

  OldUpcomingTaskTestModel({
    this.old,
    this.upcomming,
  });

  factory OldUpcomingTaskTestModel.fromJson(Map<String, dynamic> json) =>
      OldUpcomingTaskTestModel(
          old: List<TaskTestModel>.from(
            json["old"].map(
                  (x) => TaskTestModel.fromJson(x),
            ),
          ),
          upcomming: List<TaskTestModel>.from(json["upcomming"]
              .map((x) => TaskTestModel.fromJson(x))));
}