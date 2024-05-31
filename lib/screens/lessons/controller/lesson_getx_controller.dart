import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marsous1/app/utils/helpers.dart';
import 'package:marsous1/data/api/controllers/teacher_api_controller.dart';
import 'package:marsous1/models/add_review_flex_model.dart';
import 'package:marsous1/models/add_surah_model.dart';
import 'package:marsous1/models/api_response.dart';

import '../../../models/previouse_session_model.dart';
import '../../../models/submit_attendance_check_list_model.dart';
import '../../../models/surah_model.dart';

class LessonGetXController extends GetxController with Helpers {
  final TeacherApiController _teacherApiController = TeacherApiController();
  late final GlobalKey<FormState> formKey1 = GlobalKey();
  late final GlobalKey<FormState> formKey2 = GlobalKey();
  late final GlobalKey<FormState> formKey3 = GlobalKey();
  late final GlobalKey<FormState> formKey4 = GlobalKey();
  ApiResponse? apiResponse;
  PreviousSessionModel? previousLessons;
  List<SurahModel> surahList = [];
  var isLoading = true;
  List<String> suraListString = [];
  AddReviewFlexModel addReviewFlexModel = AddReviewFlexModel();
  AddSurahModel memorizeSurahModel = AddSurahModel();
  AddSurahModel nearReviewSurahModel = AddSurahModel();
  AddSurahModel farReviewSurahModel = AddSurahModel();
  TextEditingController fromSurahTextEditingController =
      TextEditingController();
  TextEditingController toSurahTextEditingController = TextEditingController();
  TextEditingController tajwidSurahTextEditingController =
      TextEditingController();

  final SubmitAttendanceCheckListModel submitAttendanceCheckListModel =
      SubmitAttendanceCheckListModel();

  List<SubmitAttendanceCheckListModel> attendanceList = [];

  void submitAttendanceCheckList({required BuildContext context}) async {
    showLoadingDialog(context: context, title: "Loading...");
    try {
      apiResponse = await _teacherApiController.submitAttendanceCheckList(
          attendanceList: attendanceList);
      Navigator.of(context).pop();
      if (apiResponse!.status == 200) {
        showSnackBar(context, message: "${apiResponse?.message}");
      } else {
        showSnackBar(context, message: "${apiResponse?.message}", error: true);
      }
      update();
    } catch (e) {
      print("teacher - submit attendance list error : $e");
      Navigator.of(context).pop();
      showSnackBar(context, message: "$e", error: true);
    }
  }

  void getPreviousLessons(
      {String? courseId = "", int? pageIndex, int? pageSize}) async {
    try {
      // print("Teacher - prevoius lesson getx controller1 : $previousLessons");
      previousLessons = await _teacherApiController.getPreviousSessionTeacher(
          courseId: courseId, pageSize: pageSize, pageIndex: pageIndex);
      print("teacher - prevoius lesson getx controller : $previousLessons");
      update();
    } catch (e) {
      print("teacher - previous lesson error : $e");
    }
  }

  void getSurahList() async {
    isLoading = true;
    try {
      surahList = await _teacherApiController.getSurahList();
      for (int i = 0; i < surahList.length; i++) {
        suraListString.add(surahList[i].name!);
      }
      isLoading = false;
      update();
    } catch (e) {
      print("teacher - get surah list error : $e");
    }
  }

  void addReviewFlex({required BuildContext context}) async {
    if (formKey1.currentState?.validate() ?? false) {
      formKey1.currentState!.save();
      addReviewFlexModel.sessionMemorize = memorizeSurahModel;
    }
    if (formKey2.currentState?.validate() ?? false) {
      formKey2.currentState!.save();
      addReviewFlexModel.nearReview = nearReviewSurahModel;
    }
    if (formKey3.currentState?.validate() ?? false) {
      formKey3.currentState!.save();
      addReviewFlexModel.farReview = farReviewSurahModel;
    }
    if (formKey4.currentState?.validate() ?? false) {
      formKey4.currentState!.save();
    }
    if (addReviewFlexModel.sessionMemorize?.surahId == null) {
      addReviewFlexModel.sessionMemorize = null;
    }
    if (addReviewFlexModel.nearReview?.surahId == null) {
      addReviewFlexModel.nearReview = null;
    }
    if (addReviewFlexModel.farReview?.surahId == null) {
      addReviewFlexModel.farReview = null;
    }
    if (addReviewFlexModel.sessionTajweed == null ||
        addReviewFlexModel.sessionTajweed!.isEmpty) {
      addReviewFlexModel.sessionTajweed = null;
    }
    showLoadingDialog(context: context, title: "loading");
    try {
      apiResponse = await _teacherApiController.addReviewFlex(
          addReviewFlexModel: addReviewFlexModel);
      Navigator.of(context).pop();
      if (apiResponse!.status == 200) {
        showSnackBar(context, message: apiResponse!.message);
      } else {
        showSnackBar(context, message: apiResponse!.message, error: true);
      }
      update();
    } catch (e) {
      print("teacher - add review flex error: $e");
    }
  }
}
