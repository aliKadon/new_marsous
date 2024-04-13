import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../home/home_view.dart';
import '../../homework/homework_view.dart';
import '../../notifications/notifications_view.dart';
import '../../tests/tests_view.dart';



class MainRoutGetxController extends GetxController {

  int? index;

  late int currentIndex = index ?? 0;

  List<Widget> screens = [
    const HomeView(),
    const NotificationsView(),
    const HomeWorkView(),
    const TestsView(),
  ];


  void changeBottom(int index, BuildContext context) {
    currentIndex = index;
    update();
  }

}