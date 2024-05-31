import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/session_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../screens/student_screens/student_homework/student_homework_details_view.dart';
import '../../screens/student_screens/student_homework/student_homework_lesson_view.dart';

class StudentHomeworkItem extends StatelessWidget {
  final String tag;
  final SessionModel sessionModel;
  final int isSelected;

  const StudentHomeworkItem(
      {super.key,
      required this.tag,
      required this.sessionModel,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionModel>(
      tag: tag,
      builder: (controller) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => isSelected == 1
                  // ? StudentHomeworkDetailsView(tag: tag,)
                  ? StudentHomeworkDetailsView(
                      tag: tag,
                    )
                  : StudentHomeworkLessonView(session: controller),
            ),
          );
        },
        child: Container(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                   isSelected == 1
                          ? Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(50.r)),
                              child: Image.asset(
                                IconsAssets.book,
                                height: 25.h,
                              ),
                            )
                      : Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50.r)),
                          child: Image.asset(
                            IconsAssets.circleBook,
                            height: 40.h,
                          ),
                        ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat('yMMMMEEEEd', 'ar')
                                .format(DateTime.parse(sessionModel.date!)),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 220.w,
                        child: Text(
                          "${sessionModel.lessonTask}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
