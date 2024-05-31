import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marsous1/models/old_upcoming_task_test_model.dart';
import 'package:marsous1/models/submit_task_grade_model.dart';
import 'package:marsous1/models/submit_test_grade_model.dart';
import 'package:marsous1/models/surah_model.dart';
import 'package:marsous1/models/task_student_model.dart';

import '../../../models/add_review_flex_model.dart';
import '../../../models/api_response.dart';
import '../../../models/course_model.dart';
import '../../../models/info_student_session_test_model.dart';
import '../../../models/previouse_session_model.dart';
import '../../../models/session_model.dart';
import '../../../models/submit_attendance_check_list_model.dart';
import '../../../models/submit_grade_model.dart';
import '../../../models/test_student_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class TeacherApiController with ApiHelper {
  ApiResponse? apiResponse;

  Future<List<CourseModel>> getTeacherCourses(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-courses?pageIndex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headersTeacher);


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
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        apiResponse = ApiResponse(
            status: jsonData["status"], message: jsonData["message"]);
        return List<SessionModel>.from(
          jsonData["data"].map(
            (x) => SessionModel.fromJson(x),
          ),
        );
      } else if (jsonData["status"] == 400) {
        apiResponse =
            ApiResponse(status: jsonData["status"], message: jsonData["data"]);
        return [];
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

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> submitGradeTask(
      {required List<SubmitGradeTaskModel> submitGradeTask}) async {
    var url =
        Uri.parse("${ApiSettings.baseUrl}/Tutor/submit-student-task-grades");
    var body = submitGradeTask.map((e) => jsonEncode(e.toJson())).toList();
    var response = await http.post(url,
        headers: headersTeacher,
        body: jsonEncode(submitGradeTask.map((e) => e.toJson()).toList()));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> submitGradeTest(
      {required List<SubmitTestGradeModel> submitGradeTest}) async {
    var url =
        Uri.parse("${ApiSettings.baseUrl}/Tutor/submit-student-test-grades");
    var body = submitGradeTest.map((e) => jsonEncode(e.toJson())).toList();
    var response = await http.post(url,
        headers: headersTeacher,
        body: jsonEncode(submitGradeTest.map((e) => e.toJson()).toList()));

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

  Future<PreviousSessionModel?> getPreviousSessionTeacher(
      {String? courseId, int? pageIndex, int? pageSize}) async {

    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-previous-session?pageIndex=$pageIndex&pageSize=$pageSize&courseId=$courseId");
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return PreviousSessionModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<OldUpcomingTaskTestModel?> getTaskList(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-tasks?pageindex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return OldUpcomingTaskTestModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<OldUpcomingTaskTestModel?> getTestList(
      {int? pageIndex, int? pageSize}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-my-tests?pageindex=$pageIndex&pageSize=$pageSize");
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return OldUpcomingTaskTestModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<List<TaskStudentModel>> getTaskStudentList(
      {int? pageIndex, int? pageSize, required String courseId}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-student-task-list?pageindex=$pageIndex&pageSize=$pageSize&CourseSessionId=$courseId");
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<TaskStudentModel>.from(
          jsonData["data"].map(
            (x) => TaskStudentModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<List<TestStudentModel>> getTestStudentList(
      {int? pageIndex, int? pageSize, required String courseId}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-student-test-list?pageindex=$pageIndex&pageSize=$pageSize&CourseSessionId=$courseId");
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<TestStudentModel>.from(
          jsonData["data"].map(
            (x) => TestStudentModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<InfoStudentSessionTestModel?> getInfoStudentSessionTest(
      {required String studentId}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/get-student-info-sessions-tests?studentId=$studentId");
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return InfoStudentSessionTestModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }

  Future<List<SurahModel>> getSurahList() async {
    var url = Uri.parse("${ApiSettings.baseUrl}/Tutor/get-surah-list");
    var response = await http.get(url, headers: headers);


    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<SurahModel>.from(
          jsonData["data"].map(
            (x) => SurahModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<ApiResponse> addReviewFlex(
      {AddReviewFlexModel? addReviewFlexModel}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Tutor/create-student-flexilble-session");
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(addReviewFlexModel),
    );
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
