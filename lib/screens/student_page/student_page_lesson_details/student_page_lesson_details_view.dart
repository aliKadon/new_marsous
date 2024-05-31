import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/session_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class StudentPageLessonDetailsView extends StatelessWidget {
  final SessionModel sessionModel;

  const StudentPageLessonDetailsView({super.key, required this.sessionModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yMMMMEEEEd', 'ar').format(
            DateTime.parse(sessionModel.date ?? "2024-04-18T15:15:00"))),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(10.w),
        color: Colors.grey.withOpacity(0.1),
        child: SingleChildScrollView(
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
                    "سجل المنهج",
                    style:
                    TextStyle(color: Colors.black, fontSize: FontSize.s16),
                  ),
                ],
              ),
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
                child: Column(
                  children: [
                    sessionModel.lessonMemorize == null ||
                        sessionModel.lessonMemorize!.isEmpty
                        ? Container()
                        : lessonItem(
                        title: "${sessionModel.lessonMemorize}",
                        note: "",
                        type: "التسميع"),
                    sessionModel.lessonMemorize == null ||
                        sessionModel.lessonMemorize!.isEmpty
                        ? Container()
                        : Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1,
                    ),
                    sessionModel.lessonFarReview == null ||
                        sessionModel.lessonFarReview!.isEmpty
                        ? Container()
                        : lessonItem(
                        title: "${sessionModel.lessonFarReview}",
                        note: "",
                        type: "المراجعه البعيدة"),
                    sessionModel.lessonFarReview == null ||
                        sessionModel.lessonFarReview!.isEmpty
                        ? Container()
                        : Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1,
                    ),
                    sessionModel.lessonNearReview == null ||
                        sessionModel.lessonNearReview!.isEmpty
                        ? Container()
                        : lessonItem(
                        title: "${sessionModel.lessonNearReview}",
                        note: "",
                        type: "المراجعة القريبه"),
                    sessionModel.lessonNearReview == null ||
                        sessionModel.lessonNearReview!.isEmpty
                        ? Container()
                        : Divider(
                      color: Colors.grey.withOpacity(0.3),
                      thickness: 1,
                    ),
                    sessionModel.lessonTajweed == null ||
                        sessionModel.lessonTajweed!.isEmpty
                        ? Container()
                        : lessonItem(
                        title: "${sessionModel.lessonTajweed}",
                        note: "",
                        type: "التجويد"),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
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
                    "سؤال الواجب",
                    style:
                    TextStyle(color: Colors.black, fontSize: FontSize.s16),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.r),
                    )),
                child: sessionModel.lessonTask == null ||
                    sessionModel.lessonTask!.isEmpty
                    ? Text("لا يوجد واجب",
                    style: TextStyle(
                        color: Colors.black, fontSize: FontSize.s14))
                    : Row(
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Text(
                          "${sessionModel.lessonTask}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s14)),
                    ),
                    const Spacer(),
                    sessionModel.taskAnswer!.isEmpty &&
                        sessionModel.taskFilePath!.isEmpty ? Container(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 5.w, right: 15.w, left: 15.w),
                      decoration: BoxDecoration(
                        color: const Color(0x19E05858),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "لم يكتمل",
                        style: TextStyle(
                            color: const Color(0x19E05858),
                            fontWeight: FontWeight.w800,
                            fontSize: FontSize.s14),
                      ),
                    ) : Container(
                      padding: EdgeInsets.only(
                          top: 5.w, bottom: 5.w, right: 15.w, left: 15.w),
                      decoration: BoxDecoration(
                        color: const Color(0x19E05858),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "مكتمل",
                        style: TextStyle(
                            color: const Color(0xFFE05858),
                            fontWeight: FontWeight.w800,
                            fontSize: FontSize.s14),
                      ),
                    ),
                  ],
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
    required String note,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 300.w,
                child: Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w500)),
              ),
              const Spacer(),
              // Stack(
              //   children: [
              //     Image.asset(
              //       ImageAssets.star,
              //       height: 40.h,
              //     ),
              //     Positioned.fill(
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Text(
              //           "10",
              //           style: TextStyle(color: ColorManager.primary),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
          Text(type, style: TextStyle(color: ColorManager.primary)),
          Text(note,
              style: TextStyle(color: Colors.grey, fontSize: FontSize.s13)),
        ],
      ),
    );
  }
}
