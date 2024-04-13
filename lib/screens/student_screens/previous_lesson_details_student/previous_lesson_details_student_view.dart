import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/session_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

class PreviousLessonDetailsStudentView extends StatefulWidget {
  final String episodeTitle;
  final SessionModel sessionModel;

  const PreviousLessonDetailsStudentView(
      {super.key, required this.episodeTitle, required this.sessionModel});

  @override
  State<PreviousLessonDetailsStudentView> createState() =>
      _PreviousLessonDetailsStudentViewState();
}

class _PreviousLessonDetailsStudentViewState
    extends State<PreviousLessonDetailsStudentView> {
  bool getLessonReviewed() {
    if (widget.sessionModel.lessonMemorize!.isEmpty &&
        widget.sessionModel.lessonTajweed!.isEmpty &&
        widget.sessionModel.lessonFarReview!.isEmpty &&
        widget.sessionModel.lessonNearReview!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episodeTitle),
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
                child: getLessonReviewed()
                    ? Column(
                        children: [
                          widget.sessionModel.lessonMemorize!.isNotEmpty
                              ? Column(
                                  children: [
                                    lessonItem(
                                        title:
                                            "${widget.sessionModel.lessonMemorize}",
                                        // note: "لا يوجد ملاحظات",
                                        type: "التسميع"),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ],
                                )
                              : Container(),
                          widget.sessionModel.lessonNearReview!.isNotEmpty
                              ? Column(
                                  children: [
                                    lessonItem(
                                        title:
                                            "${widget.sessionModel.lessonNearReview}",
                                        // note: "لا يوجد ملاحظات",
                                        type: "المراجعة القريبة"),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ],
                                )
                              : Container(),
                          widget.sessionModel.lessonFarReview!.isNotEmpty
                              ? Column(
                                  children: [
                                    lessonItem(
                                        title:
                                            "${widget.sessionModel.lessonFarReview}",
                                        // note: "لا يوجد ملاحظات",
                                        type: "المراجعة البعيدة"),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ],
                                )
                              : Container(),
                          widget.sessionModel.lessonTajweed!.isNotEmpty
                              ? Column(
                                  children: [
                                    lessonItem(
                                        title:
                                            "${widget.sessionModel.lessonTajweed}",
                                        // note: "لا يوجد ملاحظات",
                                        type: "التجويد"),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.3),
                                      thickness: 1,
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      )
                    :
                Center(
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
          Row(
            children: [
              Text(type, style: TextStyle(color: ColorManager.primary)),
              const Spacer(),
              Stack(
                children: [
                  Image.asset(
                    ImageAssets.star,
                    height: 40.h,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "10",
                        style: TextStyle(color: ColorManager.primary),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(note ?? "لا يوجد ملاحظات",
              style: TextStyle(color: Colors.grey, fontSize: FontSize.s13)),
        ],
      ),
    );
  }
}
