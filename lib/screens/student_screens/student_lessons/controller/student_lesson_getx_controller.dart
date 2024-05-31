import 'package:get/get.dart';

import '../../../../data/api/controllers/student_api_controller.dart';
import '../../../../models/previouse_session_model.dart';

class StudentLessonGetXController extends GetxController {
  final StudentApiController _studentApiController = StudentApiController();

  PreviousSessionModel? previousLessons;

  var isLoading = true;


  void getPreviousLessons(
      {String? courseId = "", int? pageIndex, int? pageSize}) async {
    isLoading = true;
    try {
      // print("student - prevoius lesson getx controller1 : $previousLessons");
      previousLessons = await _studentApiController.getPreviousSession(
          courseId: courseId, pageSize: pageSize, pageIndex: pageIndex);
      print("student - prevoius lesson getx controller : $previousLessons");
      isLoading = false;
      update();
    }catch (e) {
      print("student - previous lesson error : $e");
      isLoading = false;
      update();
    }
  }


}
