import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/session_model.dart';
import 'package:marsous1/screens/student_screens/student_homework/controller/student_homework_getx_controller.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class StudentHomeworkDetailsView extends StatefulWidget {
  final String tag;

  const StudentHomeworkDetailsView({super.key, required this.tag});

  @override
  State<StudentHomeworkDetailsView> createState() =>
      _StudentHomeworkDetailsViewState();
}

class _StudentHomeworkDetailsViewState
    extends State<StudentHomeworkDetailsView> {
  //controller
  final StudentHomeworkGetXController studentHomeworkGetXController =
      Get.put(StudentHomeworkGetXController());

  final _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionModel>(
      tag: widget.tag,
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
              "تفاصيل واجب ${DateFormat('yMMMMEEEEd', 'ar').format(DateTime.parse(controller.date!))}"),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssets.aboutUsStar,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        "${controller.lessonTask}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s14),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    (controller.taskFilePath!.isEmpty ||
                            controller.taskFilePath == null)
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.w),
                            margin: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text("${controller.taskAnswer}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w500)),
                          )
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.w),
                            margin: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                                "يمكنك تنزيل ملف الواجب بصيغة PDF أو صورة!!!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeight.w500)),
                          ),
                    (controller.taskFilePath!.isEmpty ||
                            controller.taskFilePath == null)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              studentHomeworkGetXController.downloadFile(
                                  sessionModel: controller, context: context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.w),
                              margin: EdgeInsets.all(10.w),
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
                                    style:
                                        TextStyle(color: ColorManager.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        children: [
                          Text(
                            "الدرجة",
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14),
                          ),
                          const Spacer(),
                          controller.taskGrade == -1
                              ? const Text(
                                  "لم يتم تصحيح الواجب بعد",
                                  style: TextStyle(color: Colors.grey),
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
                                          "${controller.taskGrade}",
                                          style: TextStyle(
                                              color: ColorManager.primary),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
