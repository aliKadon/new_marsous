import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';


class StudentLessonItem extends StatelessWidget {
  const StudentLessonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Image.asset(
            ImageAssets.studentImage,
            height: 100.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "محمد عبد الله عبد الله",
            style: TextStyle(
                color: ColorManager.secondaryDark, fontWeight: FontWeight.w700),
          ),
          const Text(
            "#255255 ",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
