import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/api_response.dart';
import '../../../models/course_model.dart';
import '../../../models/session_model.dart';
import '../../../models/submit_attendance_check_list_model.dart';
import '../../../models/submit_grade_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class TeacherApiController with ApiHelper {
  Future<List<CourseModel>> getTeacherCourses(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-courses?pageIndex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headersTeacher);

    print(
        "teacher - get courses response status code : ${response.statusCode}");
    print("teacher - get courses response body : ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<CourseModel>.from(
          jsonData["data"].map(
            (x) => CourseModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<List<SessionModel>> getTeacherSession(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-session?pageIndex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headersTeacher);

    print(
        "Teacher - my session api response status code: ${response.statusCode} ");
    print("Teacher - my session api response body: ${response.body} ");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<SessionModel>.from(
          jsonData["data"].map(
            (x) => SessionModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<List<SessionModel>> getStudentSession(
      {required String sessionId}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-session-student-list?sessionId=$sessionId");
    var response = await http.get(url, headers: headersTeacher);
    print(
        "teacher - get student session : response status code : ${response.statusCode}");
    print("teacher - get student session : response body : ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<SessionModel>.from(
          jsonData["data"].map(
            (x) => SessionModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<ApiResponse> submitGrade(
      {required List<SubmitGradeModel> submitGradeList}) async {
    var url =
        Uri.parse("${ApiSettings.baseUrl}/Tutor/submit-session-grade-list");
    var body = submitGradeList.map((e) => jsonEncode(e.toJson())).toList();
    var response = await http.post(url,
        headers: headersTeacher,
        body: jsonEncode(submitGradeList.map((e) => e.toJson()).toList()));
    print("teacher - subit grade list : $body");
    print(
        "teacher - get student session : response status code : ${response.statusCode}");
    print("teacher - get student session : response body : ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> submitAttendanceCheckList(
      {required List<SubmitAttendanceCheckListModel> attendanceList}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/submit-session-attendance-check-list");
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode(attendanceList.map((e) => e.toJson()).toList()));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }
}
