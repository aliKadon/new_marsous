import 'package:get/get.dart';
import 'package:marsous1/models/test_student_model.dart';

import '../../../../data/api/controllers/teacher_api_controller.dart';

class TestDetailsGetxController extends GetxController {
  final TeacherApiController _teacherApiController = TeacherApiController();

  var isLoading = true;

  List<TestStudentModel> testStudentList = [];


  void getTestStudentList(
      {int? pageIndex, int? pageSize, required String courseId}) async {
    isLoading = true;
    try {
      testStudentList = await _teacherApiController.getTestStudentList(
          courseId: courseId, pageIndex: pageIndex, pageSize: pageSize);
      isLoading = false;
      update();
    } catch (e) {
      print("teacher - Test details - get test student list error : $e ");
      isLoading = false;
    }
  }
}