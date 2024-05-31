import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/test_info_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class StudentPageTestDetails extends StatelessWidget {
  final TestInfoModel testInfoModel;

  const StudentPageTestDetails({super.key, required this.testInfoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yMMMMEEEEd', 'ar').format(
            DateTime.parse(testInfoModel.date ?? "2024-04-18T15:15:00"))),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImageAssets.aboutUsStar,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "سجل الاختبار",
                        style: TextStyle(
                            color: Colors.black, fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                  Text(
                    "${testInfoModel.lessonTest}",
                    style:
                        TextStyle(color: Colors.grey, fontSize: FontSize.s14),
                  ),
                  SizedBox(height: 7.h),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Text(
                        "التقيم",
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s14),
                      ),
                      const Spacer(),
                      testInfoModel.testGrade == -1
                          ? Text(
                              "لم يتم التقييم بعد",
                              style: TextStyle(color: ColorManager.primary),
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
                                      "${testInfoModel.testGrade}",
                                      style: TextStyle(
                                          color: ColorManager.primary),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
