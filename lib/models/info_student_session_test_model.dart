import 'package:marsous1/models/session_model.dart';
import 'package:marsous1/models/test_info_model.dart';
import 'package:marsous1/models/user_info_model.dart';

class InfoStudentSessionTestModel {
  UserInfoModel? info;
  List<SessionModel>? oldSessions;
  List<SessionModel>? upcommingSessions;
  List<TestInfoModel>? oldTests;
  List<TestInfoModel>? upCommingTests;

  InfoStudentSessionTestModel({
    this.info,
    this.oldSessions,
    this.oldTests,
    this.upcommingSessions,
    this.upCommingTests,
  });

  factory InfoStudentSessionTestModel.fromJson(Map<String, dynamic> json) =>
      InfoStudentSessionTestModel(
        info:
            json["info"] == null ? null : UserInfoModel.fromJson(json["info"]),
        oldSessions: List<SessionModel>.from(
            json["oldSessions"].map((x) => SessionModel.fromJson(x))),
        upcommingSessions: List<SessionModel>.from(
            json["upcommingSessions"].map((x) => SessionModel.fromJson(x))),
        oldTests: List<TestInfoModel>.from(
            json["oldTests"].map((x) => TestInfoModel.fromJson(x))),
        upCommingTests: List<TestInfoModel>.from(
            json["upCommingTests"].map((x) => TestInfoModel.fromJson(x))),
      );
}
