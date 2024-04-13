import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:marsous1/models/session_model.dart';
import 'package:marsous1/screens/home/student_session_getx_controller/student_session_getx_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../widgets/recording_attendance_item.dart';
import '../../widgets/shimmer_loading/shimmer_loading_task_test_item.dart';

class ConstantRecordingAttendaceView extends StatefulWidget {
  final String sessionId;

  const ConstantRecordingAttendaceView({super.key, required this.sessionId});

  @override
  State<ConstantRecordingAttendaceView> createState() =>
      _ConstantRecordingAttendaceViewState();
}

class _ConstantRecordingAttendaceViewState
    extends State<ConstantRecordingAttendaceView> {
  //controller
  final StudentSessionGetXController studentSessionGetXController =
      Get.put(StudentSessionGetXController());

  int? isSelected;

  @override
  void initState() {
    studentSessionGetXController.getStudentSession(
        sessionId: "7aa78136-5702-431d-0d44-08dc586e73a0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الحضور"),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15.r))),
            //   child: Padding(
            //     padding: EdgeInsets.all(8.w),
            //     child: Row(
            //       children: [
            //         Container(
            //           padding: EdgeInsets.all(5.w),
            //           decoration: BoxDecoration(
            //             color: const Color(0xFFF9F1E9),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(10.r),
            //             ),
            //           ),
            //           child: Image.asset(IconsAssets.searchIcon, height: 23.h),
            //         ),
            //         SizedBox(
            //           width: 300.w,
            //           child: TextFormField(
            //             decoration: InputDecoration(
            //               hintText: "بحث بإسم الطالب",
            //               hintStyle: TextStyle(color: Colors.grey,fontSize: FontSize.s14),
            //               focusedBorder: InputBorder.none,
            //               disabledBorder: InputBorder.none,
            //               enabledBorder: InputBorder.none,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            GetBuilder<StudentSessionGetXController>(
              builder: (controller) => controller.isLoading
                  ? Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return getShimmerLoading();
                      },
                    ))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.studentSession.length,
                        itemBuilder: (context, index) {
                          Get.put<SessionModel>(
                              controller.studentSession[index],
                              tag: "${controller.studentSession[index].id}");
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = index;
                              });
                            },
                            child: isSelected == null
                                ? RecordingAttendanceItem(
                                    tag:
                                        "${controller.studentSession[index].id}",
                                    isSelected: false,
                                    isFlex: false,
                                  )
                                : isSelected == index
                                    ? RecordingAttendanceItem(
                                        tag:
                                            "${controller.studentSession[index].id}",
                                        isSelected: true,
                                        isFlex: false,
                                      )
                                    : RecordingAttendanceItem(
                                        tag:
                                            "${controller.studentSession[index].id}",
                                        isSelected: false,
                                        isFlex: false),
                          );
                        },
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.w),
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
                    child: const Text("تأكيد",
                        style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ShimmerLoadingTaskTestItem());
  }
}
