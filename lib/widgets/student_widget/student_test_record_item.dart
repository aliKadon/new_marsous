import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../screens/student_page/student_page_test_details/student_page_test_details_view.dart';

class StudentTestRecord extends StatefulWidget {
  final bool isAttendance;

  const StudentTestRecord({super.key, required this.isAttendance});

  @override
  State<StudentTestRecord> createState() => _StudentTestRecordState();
}

class _StudentTestRecordState extends State<StudentTestRecord> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const StudentPageTestDetails(),
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
                Icon(Icons.date_range, color: ColorManager.primary),
                SizedBox(width: 5.w),
                Text(
                  "الخميس | 16 مارس 2023",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s13),
                ),
                const Spacer(),
                widget.isAttendance == true
                    ? const Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                    : Container(
                        padding: EdgeInsets.only(
                            top: 5.w, bottom: 5.w, right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0x19E05858),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "غائب",
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
    );
  }
}
