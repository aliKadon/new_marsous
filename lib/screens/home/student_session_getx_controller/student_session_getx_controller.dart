import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marsous1/app/utils/helpers.dart';

import '../../../data/api/controllers/teacher_api_controller.dart';
import '../../../models/session_model.dart';

class StudentSessionGetXController extends GetxController with Helpers {
  var isLoading = true;

  final TeacherApiController teacherApiController = TeacherApiController();
  List<SessionModel> studentSession = [];

  void getStudentSession(
      {required BuildContext context, required String sessionId}) async {
    isLoading = true;
    try {
      studentSession =
          await teacherApiController.getStudentSession(sessionId: sessionId);

      isLoading = false;
      if (teacherApiController.apiResponse!.status == 400) {
        showSnackBar(context,
            message: "${teacherApiController.apiResponse?.message}",
            error: true);
      }

      update();
    } catch (e) {
      print("teacher - student session error : $e");
    }
  }
}
