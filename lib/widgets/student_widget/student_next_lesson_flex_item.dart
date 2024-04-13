import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/session_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../screens/student_screens/student_homework/student_homework_lesson_view.dart';

class StudentNextLessonFlexItem extends StatelessWidget {
  final SessionModel sessionModel;

  const StudentNextLessonFlexItem({super.key, required this.sessionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.w),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.all(13.w),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: ColorManager.primary,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "الخميس | 17 مارس 2023",
                    style:
                        TextStyle(color: Colors.black, fontSize: FontSize.s14),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
              sessionModel.lessonTask == null ||
                      sessionModel.lessonTask!.isEmpty
                  ? Container()
                  : SizedBox(height: 20.h),
              sessionModel.lessonTask == null ||
                      sessionModel.lessonTask!.isEmpty
                  ? Container()
                  : Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentHomeworkLessonView(
                                session: sessionModel),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey)),
                          child: Text("عرض الواجب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
