import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../models/api_response.dart';
import '../../../models/course_model.dart';
import '../../../models/get_task_student_model.dart';
import '../../../models/get_test_student_model.dart';
import '../../../models/previouse_session_model.dart';
import '../../../models/session_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class StudentApiController with ApiHelper {
  // var sharedTokedChild = SharedPrefController().tokenChild;

  Future<List<CourseModel>> getMyCourses(
      {int? pageIndex, int? pageSize}) async {


    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/get-my-courses?pageIndex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(
      url,
      headers: headers,
    );
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

  Future<ApiResponse> sendTask(
      {required String sessionId, String? answer, File? file}) async {

    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/send-session-task-answer?sessionId=$sessionId&taskAnswer=$answer");
    var request = http.MultipartRequest(
      "POST",
      url,
    );
    request.headers.addAll(headers);
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath('taskFile', file.path),
      );
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }

  Future<PreviousSessionModel?> getPreviousSession(
      {String? courseId, int? pageIndex, int? pageSize}) async {

    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/get-my-previous-session?pageIndex=$pageIndex&pageSize=$pageSize&courseId=$courseId");
    var response = await http.get(url, headers: headers);



    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return PreviousSessionModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<List<SessionModel>> getMySession(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/get-my-session?pageIndex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headers);


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

  Future<GetTaskStudentModel?> getStudentTask(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/get-my-tasks?pageindex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headers);


    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return GetTaskStudentModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<GetTestStudentModel?> getStudentTest(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Student/get-my-tests?pageindex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headers);


    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return GetTestStudentModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }
}
