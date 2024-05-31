import 'package:get/get.dart';
import 'package:marsous1/data/api/controllers/teacher_api_controller.dart';
import 'package:marsous1/models/info_student_session_test_model.dart';

class StudentPageGetxController extends GetxController {
  final TeacherApiController _teacherApiController = TeacherApiController();

  InfoStudentSessionTestModel? infoStudentSessionTestModel;
  var isLoading = true;

  void getStudentInfoSessionTest({required String studentId}) async {
    isLoading = true;
    try {
      infoStudentSessionTestModel = await _teacherApiController
          .getInfoStudentSessionTest(studentId: studentId);
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
    }
  }
}
