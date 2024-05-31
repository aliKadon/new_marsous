import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/submit_test_grade_model.dart';

import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../app/utils/helpers.dart';
import '../../../data/api/controllers/teacher_api_controller.dart';
import '../../../models/old_upcoming_task_test_model.dart';
import '../../../models/test_student_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/values_manager.dart';
import '../../home/submit_grade_getx_controller/submit_grade_getx_controller.dart';

class TestGetxController extends GetxController {
  int mark = 0;
  String? birthDate;
  bool isSelected = false;
  bool isSelected1 = false;
  bool isLoading = true;
  SubmitTestGradeModel submitTestGrade = SubmitTestGradeModel();
  List<SubmitTestGradeModel> submitGradeList = [];
  OldUpcomingTaskTestModel? testList;

  late final TextEditingController selectDateTextEditingController =
      TextEditingController();

  final TeacherApiController _teacherApiController = TeacherApiController();

  void getTestList({int? pageIndex = 1, int? pageSize = 20}) async {
    isLoading = true;
    try {
      testList = await _teacherApiController.getTestList(
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

  Future showSheetFilter(BuildContext context) => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 20.r,
          snapSpec: const SnapSpec(
            snappings: [1.0, 0.8],
          ),
          builder: (context, state) => Material(
            child: StatefulBuilder(
              builder: (context, setState) => Padding(
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
                          "تصفية حسب",
                          style: TextStyle(
                              fontSize: FontSize.s20,
                              fontWeight: FontWeight.w800,
                              color: ColorManager.black)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: selectDateTextEditingController,
                              decoration: InputDecoration(
                                  label: const Text(
                                    "من",
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range_outlined,
                                        color: ColorManager.primary),
                                    onPressed: () =>
                                        selectDateFrom(context: context),
                                  )),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            ":",
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.s18),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextFormField(
                              controller: selectDateTextEditingController,
                              decoration: InputDecoration(
                                  label: const Text(
                                    "إلي",
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range_outlined,
                                        color: ColorManager.primary),
                                    onPressed: () =>
                                        selectDateFrom(context: context),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          label: Text(
                            "اسم الحلقة",
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text("حالة الاختبار"),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelected = true;
                                });
                              },
                              child: Row(
                                children: [
                                  isSelected == true
                                      ? Image.asset(IconsAssets.doneCircle,
                                          height: 20.h)
                                      : Image.asset(IconsAssets.circle,
                                          height: 20.h),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "تم اختباره",
                                    style: isSelected == true
                                        ? TextStyle(color: ColorManager.primary)
                                        : const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelected = false;
                                });
                              },
                              child: Row(
                                children: [
                                  isSelected == false
                                      ? Image.asset(IconsAssets.doneCircle,
                                          height: 20.h)
                                      : Image.asset(IconsAssets.circle,
                                          height: 20.h),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "لم يتم",
                                    style: isSelected == false
                                        ? TextStyle(color: ColorManager.primary)
                                        : const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
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
                              onPressed: () {},
                              child: const Text("عرض النتائج",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Future showSheetAddTestDetails(
          BuildContext context,
          SubmitGradeGetXController submitGradeGetXController,
          TestStudentModel testStudentModel) =>
      showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 20.r,
          snapSpec: const SnapSpec(
            snappings: [1.0, 0.8],
          ),
          builder: (context, state) => Material(
            child: StatefulBuilder(
              builder: (context, setState) => Padding(
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
                          "اختبر",
                          style: TextStyle(
                              fontSize: FontSize.s20,
                              fontWeight: FontWeight.w800,
                              color: ColorManager.black)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.024,
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Text(
                            "التقيم",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                mark = mark + 1;
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "$mark",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 5.w),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color(0xFFF9F1E9),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (mark > 0) {
                                  mark = mark - 1;
                                }
                              });
                            },
                            child: Image.asset(ImageAssets.minus, height: 25.h),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
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
                                submitGradeList = [];
                                submitTestGrade.testGrade = mark;
                                submitTestGrade.sessionId = testStudentModel.id;
                                // submitTestGrade.sessionId = "0b171825-1811-4c60-41ac-08dc5bc02e9e";
                                // submitGrade.taskGrade = taskTestModel.taskGrade;
                                submitGradeList.add(submitTestGrade);
                                submitTestGrade.testGrade = mark;
                                testStudentModel.updateGrade(gradeUpdated: mark);
                                testStudentModel.update();
                                submitGradeGetXController.submitGradeTest(
                                    context: context,
                                    submitGradeList: submitGradeList);
                              },
                              child: const Text("تأكيد",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
