import 'package:get/get.dart';
import 'package:marsous1/models/get_test_student_model.dart';

import '../../../../data/api/controllers/student_api_controller.dart';

class StudentTestGetxController extends GetxController {

  final StudentApiController _studentApiController = StudentApiController();

  GetTestStudentModel? getTestStudentModel;
  var isLoading = true;

  void getTestStudent({int? pageIndex, int? pageSize}) async {
    isLoading = true;
    try {
      getTestStudentModel = await _studentApiController.getStudentTest(
          pageIndex: pageIndex, pageSize: pageSize);
      isLoading = false;
      update();
    } catch (e) {
      print("student - get test student erro : $e");
      isLoading = false;
      update();
    }
  }
}