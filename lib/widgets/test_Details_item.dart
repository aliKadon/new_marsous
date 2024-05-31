import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/test_student_model.dart';
import 'package:marsous1/screens/tests/test_details/controller/test_details_getx_controller.dart';

import '../models/task_test_model.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../screens/home/submit_grade_getx_controller/submit_grade_getx_controller.dart';
import '../screens/student_page/student_page_view.dart';
import '../screens/tests/controller/test_getx_controller.dart';

class TestDetailsItem extends StatefulWidget {
  final TestStudentModel testStudentModel;
  final String tag;
  final int isSelected;
  final TaskTestModel taskModel;

  const TestDetailsItem(
      {super.key,
      required this.testStudentModel,
      required this.tag,
      required this.isSelected,
      required this.taskModel});

  @override
  State<TestDetailsItem> createState() => _TestDetailsItemState();
}

class _TestDetailsItemState extends State<TestDetailsItem> {
  //controller
  final TestGetxController _testGetxController = Get.put(
    TestGetxController(),
  );
  final SubmitGradeGetXController _submitGradeGetXController =
      Get.put(SubmitGradeGetXController());
  final TestDetailsGetxController _testDetailsGetxController =
      Get.put(TestDetailsGetxController());

  // @override
  // void dispose() {
  //   Get.delete<SessionModel>(tag: widget.tag);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return false;
      },
      child: GetBuilder<TestStudentModel>(
        tag: widget.tag,
        builder: (controller) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StudentPageView(
                  studentId: widget.testStudentModel.studentId!,
                ),
              ),
            );
          },
          child: Container(
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
                    Text(
                      "${widget.testStudentModel.fullName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s12),
                    ),
                  ],
                ),
                const Spacer(),
                widget.taskModel.isAvilableForEvaluating == false
                    ? Container()
                    : widget.testStudentModel.grade == null ||
                            widget.testStudentModel.grade == -1
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
                              _testGetxController.showSheetAddTestDetails(
                                  context,
                                  _submitGradeGetXController,
                                  widget.testStudentModel);
                            },
                            child: Text(
                              "اختبر",
                              style: TextStyle(color: ColorManager.primary),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // _testGetxController.showSheetFilter(context);
                            },
                            child: Stack(
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
                                      style: TextStyle(
                                          color: ColorManager.primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
