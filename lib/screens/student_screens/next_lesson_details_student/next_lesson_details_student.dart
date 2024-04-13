import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/session_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class NextLessonDetailsStudent extends StatelessWidget {
  final String title;
  final SessionModel sessionModel;
  NextLessonDetailsStudent({required this.sessionModel,required this.title});

  bool getLessonReviewed() {
    if (sessionModel.lessonMemorize!.isEmpty &&
        sessionModel.lessonTajweed!.isEmpty &&
        sessionModel.lessonFarReview!.isEmpty &&
        sessionModel.lessonNearReview!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(10.w),
        color: Colors.grey.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                ),
                child: getLessonReviewed() ? Column(
                  children: [
                    sessionModel.lessonMemorize!.isNotEmpty ? Column(
                      children: [
                        lessonItem(
                            title: "سشسيشسيشسيشسيشسي",
                            // note: "لا يوجد ملاحظات",
                            type: "التسميع"),
                        SizedBox(height: 15.h,),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ],
                    ) : Container(),
                    sessionModel.lessonNearReview!.isNotEmpty ? Column(
                      children: [
                        lessonItem(
                            title: "شسيشسيشسيشسيشسي",
                            // note: "لا يوجد ملاحظات",
                            type: "المراجعة القريبة"),
                        SizedBox(height: 15.h,),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ],
                    ) : Container(),
                    sessionModel.lessonFarReview!.isNotEmpty ? Column(
                      children: [
                        lessonItem(
                            title: "شسيشسيشسيشسيشسي",
                            // note: "لا يوجد ملاحظات",
                            type: "المراجعة البعيدة"),
                        SizedBox(height: 15.h,),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ],
                    ) : Container(),
                    sessionModel.lessonTajweed!.isNotEmpty ? Column(
                      children: [
                        lessonItem(
                            title: "شسيشسيشسيشسيشسي",
                            // note: "لا يوجد ملاحظات",
                            type: "التجويد"),
                        SizedBox(height: 15.h,),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ],
                    ) : Container(),
                  ],
                ) : Center(
                  child: Text("لا يوجد تقييمات حالياً.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container lessonItem({
    required String title,
    required String type,
    String? note,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 320.w,
            child: Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w500)),
          ),
          Text(type, style: TextStyle(color: ColorManager.primary)),
          // Text(note ?? "لا يوجد ملاحظات",
          //     style: TextStyle(color: Colors.grey, fontSize: FontSize.s13)),
        ],
      ),
    );
  }
}
