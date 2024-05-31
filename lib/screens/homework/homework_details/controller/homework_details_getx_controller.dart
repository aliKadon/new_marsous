import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/submit_task_grade_model.dart';
import 'package:marsous1/models/task_test_model.dart';
import 'package:marsous1/models/task_student_model.dart';

import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../app/utils/helpers.dart';
import '../../../../data/api/controllers/teacher_api_controller.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../home/submit_grade_getx_controller/submit_grade_getx_controller.dart';

class HomeworkDetailsGetxController extends GetxController with Helpers {
  final TeacherApiController _teacherApiController = TeacherApiController();

  bool isSelected = false;
  var isLoading = true;
  int mark = 0;
  SubmitGradeTaskModel submitGrade = SubmitGradeTaskModel();
  List<SubmitGradeTaskModel> submitGradeList = [];
  var _progress = 0.0;
  List<TaskStudentModel> taskStudentList = [];

  void getTaskStudentList(
      {int? pageIndex, int? pageSize, required String courseId}) async {
    isLoading = true;
    try {
      taskStudentList = await _teacherApiController.getTaskStudentList(
          courseId: courseId, pageIndex: pageIndex, pageSize: pageSize);
      isLoading = false;
      update();
    } catch (e) {
      print("teacher - homework details - get task student list error : $e ");
      isLoading = false;
    }
  }

  Future showSheetAddHomeworkDetails(
    BuildContext context,
    TaskTestModel taskModel,
    SubmitGradeGetXController submitGradeGetXController,
    TaskStudentModel taskStudentModel,
  ) =>
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
                      // Row(
                      //   children: [
                      //     Text(
                      //       "تم الحضور",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: FontSize.s14,
                      //           fontWeight: FontWeight.w600),
                      //     ),
                      //     const Spacer(),
                      //     CupertinoSwitch(
                      //       activeColor: ColorManager.primary,
                      //       value: isSelected,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           isSelected = !isSelected;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // ),
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
                                mark++;
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
                                mark--;
                              });
                            },
                            child: Image.asset(ImageAssets.minus, height: 25.h),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      taskModel.file!.isEmpty
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                print(
                                    "file url task tutor: ${taskModel.file!}");
                                FileDownloader.downloadFile(
                                  notificationType: NotificationType.all,
                                  url: taskModel.file!,
                                  name: "${taskModel.couseName} واجب",
                                  onDownloadError: (errorMessage) {
                                    Navigator.of(context).pop();
                                    popUpProgressError(
                                      context: context,
                                    );
                                  },
                                  onDownloadCompleted: (path) {
                                    Navigator.of(context).pop();
                                    File file = File(path);
                                    print("path file : $path");
                                    popUpProgressCompleted(context: context);
                                  },
                                  onProgress: (fileName, progress) {
                                    // Navigator.of(context).pop();
                                    setState(() {
                                      _progress = progress;
                                    });
                                    // popUpProgress(
                                    //     context: context,
                                    //     progress: _progress.toString());
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFCF9F5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: ColorManager.primary,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      IconsAssets.downloadIcon,
                                      height: 30.h,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "تنزيل ملف الواجب",
                                      style: TextStyle(
                                          color: ColorManager.primary),
                                    ),
                                  ],
                                ),
                              ),
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
                                submitGradeList = [];
                                submitGrade.sessionId = taskStudentModel.id;
                                submitGrade.taskGrade = mark;
                                submitGradeList.add(submitGrade);
                                // taskModel.taskGrade = mark;
                                taskStudentModel.gradeUpdated(
                                    gradeUpdated: mark);
                                taskStudentModel.update();
                                submitGradeGetXController.submitGradeTask(
                                    context: context,
                                    submitGradeList: submitGradeList);

                              },
                              child: const Text("تأكيد")),
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

  void popUpProgress(
      {required BuildContext context, required String progress}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(child: Text(progress));
      },
    );
  }

  void popUpProgressCompleted({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 200.w,
            height: 250.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done_outline,
                  color: Colors.green,
                  size: 100.h,
                ),
                Text("اكتمل التنزيل!!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
              ],
            ),
          ),
        );
      },
    );
  }

  void popUpProgressError({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 200.w,
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100.h,
                  color: Colors.red,
                ),
                Text("الرجاء المحاولة مجدداً !!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
