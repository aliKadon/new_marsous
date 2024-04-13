class SubmitAttendanceCheckListModel {
  String? sessionId;
  int? attendanceStatus;

  SubmitAttendanceCheckListModel({
    this.attendanceStatus,
    this.sessionId,
  });

  factory SubmitAttendanceCheckListModel.fromJson(Map<String, dynamic> json) =>
      SubmitAttendanceCheckListModel(
        attendanceStatus: json["attendanceStatus"],
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "attendanceStatus": attendanceStatus,
      };
}
