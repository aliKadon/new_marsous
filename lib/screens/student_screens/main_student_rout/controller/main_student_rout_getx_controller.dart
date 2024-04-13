import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../notifications/notifications_view.dart';
import '../../student_home/student_home_view.dart';
import '../../student_homework/student_homework_view.dart';
import '../../student_test/student_test_view.dart';


class MainStudentRoutGetxController extends GetxController {

  int? index;

  late int currentIndex = index ?? 0;

  List<Widget> screens = [
    const StudentHomeView(),
    const NotificationsView(),
    const StudentHomeworkView(),
    const StudentTestView(),
  ];


  void changeBottom(int index, BuildContext context) {
    currentIndex = index;
    update();
  }

}