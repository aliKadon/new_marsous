
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/submit_task_grade_model.dart';
import 'package:marsous1/models/submit_test_grade_model.dart';


import '../../../app/utils/helpers.dart';
import '../../../data/api/controllers/teacher_api_controller.dart';
import '../../../models/api_response.dart';
import '../../../models/submit_grade_model.dart';

class SubmitGradeGetXController extends GetxController with Helpers {
  final TeacherApiController _teacherApiController = TeacherApiController();
  ApiResponse? apiResponse;

  void submitGrade({required BuildContext context,required List<SubmitGradeModel> submitGradeList}) async {
    showLoadingDialog(context: context,title: "loading");
    try {
      apiResponse = await _teacherApiController.submitGrade(
          submitGradeList: submitGradeList);
      if (apiResponse!.status == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }
      update();
    } catch (e) {
      Navigator.of(context).pop();
      print("teacher - submit response error : $e");
    }
  }

  void submitGradeTask({required BuildContext context,required List<SubmitGradeTaskModel> submitGradeList}) async {
    showLoadingDialog(context: context,title: "loading");
    try {
      apiResponse = await _teacherApiController.submitGradeTask(
          submitGradeTask: submitGradeList);
      if (apiResponse!.status == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }
      update();
    } catch (e) {
      Navigator.of(context).pop();
      print("teacher - submit task grade response error : $e");
    }
  }


  void submitGradeTest({required BuildContext context,required List<SubmitTestGradeModel> submitGradeList}) async {
    showLoadingDialog(context: context,title: "loading");
    try {
      apiResponse = await _teacherApiController.submitGradeTest(
          submitGradeTest: submitGradeList);
      if (apiResponse!.status == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse!.message);
      }
      update();
    } catch (e) {
      Navigator.of(context).pop();
      print("teacher - submit test grade response error : $e");
    }
  }
}
