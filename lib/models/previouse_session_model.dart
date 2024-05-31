import 'package:marsous1/models/session_model.dart';

class PreviousSessionModel {
  List<SessionModel>? old;
  List<SessionModel>? upcomming;

  PreviousSessionModel({
    this.old,
    this.upcomming,
  });

  factory PreviousSessionModel.fromJson(Map<String, dynamic> json) =>
      PreviousSessionModel(
          old: List<SessionModel>.from(
            json["old"].map(
              (x) => SessionModel.fromJson(x),
            ),
          ),
          upcomming: List<SessionModel>.from(json["upcomming"]
              .map((x) => SessionModel.fromJson(x))));
}
