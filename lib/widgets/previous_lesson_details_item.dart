import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../models/session_model.dart';
import '../resources/assets_manager.dart';
import '../resources/font_manager.dart';
import '../screens/student_page/student_page_view.dart';

class PreviousLessonDetailsItem extends StatefulWidget {
  final String tag;
  final int isSelected;

  const PreviousLessonDetailsItem(
      {super.key, required this.tag, required this.isSelected});

  @override
  State<PreviousLessonDetailsItem> createState() =>
      _PreviousLessonDetailsItemState();
}

class _PreviousLessonDetailsItemState extends State<PreviousLessonDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionModel>(
      tag: widget.tag,
      builder: (controller) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StudentPageView(
                studentId: controller.studentId!,
              ),
            ),
          );
        },
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(13.w),
              child: Row(
                children: [
                  Image.asset(
                    ImageAssets.accountProfileImage,
                    height: 50.h,
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 170.w,
                    child: Text(
                      "${controller.studentFullName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize.s12),
                    ),
                  ),
                  const Spacer(),
                  widget.isSelected == 0
                      ? Container()
                      : controller.attendanceAsString == "حاضر"
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: 5.w,
                                  bottom: 5.w,
                                  right: 15.w,
                                  left: 15.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6F5F1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                "${controller.attendanceAsString}",
                                style: TextStyle(
                                    color: const Color(0xFF059A6D),
                                    fontWeight: FontWeight.w800,
                                    fontSize: FontSize.s14),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                  top: 5.w,
                                  bottom: 5.w,
                                  right: 15.w,
                                  left: 15.w),
                              decoration: BoxDecoration(
                                color: const Color(0x19E05858),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                "${controller.attendanceAsString}",
                                style: TextStyle(
                                    color: const Color(0xFFE05858),
                                    fontWeight: FontWeight.w800,
                                    fontSize: FontSize.s14),
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
}
