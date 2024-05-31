import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/old_upcoming_task_test_model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../app/utils/helpers.dart';
import '../../../data/api/controllers/teacher_api_controller.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/values_manager.dart';

class HomeworkGetxController extends GetxController {
  String? birthDateTo;
  String? birthDate;
  OldUpcomingTaskTestModel? taskList;

  bool isLoading = true;

  final TeacherApiController _teacherApiController = TeacherApiController();

  //controller
  late final TextEditingController selectDateTextEditingController =
      TextEditingController();
  late final TextEditingController homeworkQuestionTextEditingController =
  TextEditingController();
  late final TextEditingController homeworkTitleTextEditingController =
  TextEditingController();
  late final TextEditingController homeworkLessonTextEditingController =
  TextEditingController();


  void getTaskList({int? pageIndex = 1, int? pageSize = 20}) async {
    isLoading = true;
    try {
      taskList = await _teacherApiController.getTaskList(
          pageSize: pageSize, pageIndex: pageIndex);
      isLoading = false;
      update();
    } catch (e) {
      print("teacher - get task list error : $e");
      isLoading = false;
    }
  }



  // select date.
  void selectDateFrom({
    required BuildContext context,
  }) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: birthDate == null
          ? DateTime(DateTime.now().year)
          : DateTime.parse(birthDate!),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date == null) return;
    birthDate = Helpers.formatDate(date);
    selectDateTextEditingController.text = birthDate!;
  }

  Future showSheetAddHomework(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 20.r,
          snapSpec: const SnapSpec(
            snappings: [1.0, 0.8],
          ),
          builder: (context, state) => Material(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s15),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        "إضافة واجب",
                        style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.black)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    TextFormField(
                      controller: homeworkLessonTextEditingController,
                      decoration: const InputDecoration(
                        label: Text(
                          "اختر الحلقة",
                        ),),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: homeworkTitleTextEditingController,
                      decoration: const InputDecoration(
                        label: Text(
                          "عنوان الواجب",
                        ),),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: selectDateTextEditingController,
                      decoration: InputDecoration(
                          label: const Text(
                            "اخر معاد التسليم",
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.date_range_outlined,
                                color: ColorManager.primary),
                            onPressed: () => selectDateFrom(context: context),
                          )),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      maxLines: 4,
                      controller: homeworkQuestionTextEditingController,
                      decoration: const InputDecoration(
                          label: Text(
                            "سؤال الواجب",
                          ),),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            gradient: LinearGradient(
                              begin: const Alignment(0.00, -1.00),
                              end: const Alignment(0, 1),
                              colors: [
                                ColorManager.secondary,
                                ColorManager.secondaryDark
                              ],
                            )),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r)),
                            ),
                            onPressed: () {
                            },
                            child: const Text("إضافة")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
