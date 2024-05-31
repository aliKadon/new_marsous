import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/task_test_model.dart';
import 'package:marsous1/models/task_student_model.dart';

import '../models/session_model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../screens/home/submit_grade_getx_controller/submit_grade_getx_controller.dart';
import '../screens/homework/homework_details/controller/homework_details_getx_controller.dart';
import '../screens/student_page/student_page_view.dart';

class HomeworkDetailsItem extends StatefulWidget {
  final TaskStudentModel taskStudentModel;
  final String tag;
  final int isSelected;
  final TaskTestModel taskModel;

  const HomeworkDetailsItem(
      {super.key,
      required this.taskStudentModel,
      required this.taskModel,
      required this.tag,
      required this.isSelected});

  @override
  State<HomeworkDetailsItem> createState() => _HomeworkDetailsItemState();
}

class _HomeworkDetailsItemState extends State<HomeworkDetailsItem> {
  //controller
  final HomeworkDetailsGetxController _homeworkDetailsGetxController = Get.put(
    HomeworkDetailsGetxController(),
  );
  final SubmitGradeGetXController _submitGradeGetXController = Get.put(
    SubmitGradeGetXController(),
  );

  @override
  void dispose() {
    Get.delete<SessionModel>(tag: widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudentPageView(
              studentId: widget.taskStudentModel.studentId!,
            ),
          ),
        );
      },
      child: GetBuilder<TaskStudentModel>(
        tag: widget.tag,
        builder: (controller) => Container(
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageAssets.accountProfileImage,
                height: 50.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "#255255",
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      "${controller.fullName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s12),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              widget.taskModel.isAvilableForEvaluating == false
                  ? Container()
                  : widget.taskStudentModel.grade == null ||
                          widget.taskStudentModel.grade == -1
                      ? ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                side: BorderSide(color: ColorManager.primary),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _homeworkDetailsGetxController
                                .showSheetAddHomeworkDetails(
                                    context,
                                    widget.taskModel,
                                    _submitGradeGetXController,
                                    widget.taskStudentModel);
                          },
                          child: Text(
                            "صحح",
                            style: TextStyle(color: ColorManager.primary),
                          ),
                        )
                      : Stack(
                          children: [
                            Image.asset(
                              ImageAssets.star,
                              height: 40.h,
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${controller.grade}",
                                  style: TextStyle(color: ColorManager.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
