import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/session_model.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../screens/student_page/student_page_lesson_details/student_page_lesson_details_view.dart';

class StudentLessonRecordItem extends StatefulWidget {
  final SessionModel sessionModel;

  const StudentLessonRecordItem({super.key, required this.sessionModel});

  @override
  State<StudentLessonRecordItem> createState() =>
      _StudentLessonRecordItemState();
}

class _StudentLessonRecordItemState extends State<StudentLessonRecordItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudentPageLessonDetailsView(
              sessionModel: widget.sessionModel,
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
                Icon(Icons.date_range, color: ColorManager.primary),
                SizedBox(width: 5.w),
                Text(
                  DateFormat('yMMMMEEEEd', 'ar').format(DateTime.parse(
                      widget.sessionModel.date ?? "2024-04-18T15:15:00")),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s13),
                ),
                const Spacer(),
                widget.sessionModel.attendance == 1
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      )
                    : Container(
                        padding: EdgeInsets.only(
                            top: 5.w, bottom: 5.w, right: 15.w, left: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0x19E05858),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          "${widget.sessionModel.attendanceAsString}",
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
