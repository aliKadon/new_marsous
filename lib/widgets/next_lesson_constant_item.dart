import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/session_model.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../screens/lessons/constant_lesson/constant_recording_attendance_view.dart';

class NextLessonConstantItem extends StatefulWidget {
  final int index;
  final String tag;
  final SessionModel sessionModel;

  const NextLessonConstantItem(
      {super.key,
      required this.tag,
      required this.index,
      required this.sessionModel});

  @override
  State<NextLessonConstantItem> createState() => _NextLessonConstantItemState();
}

class _NextLessonConstantItemState extends State<NextLessonConstantItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionModel>(
      tag: widget.tag,
      builder: (controller) => Container(
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
                      DateFormat('yMMMMEEEEd', 'ar').format(DateTime.parse(widget.sessionModel.date!)),
                      style: TextStyle(
                          color: Colors.black, fontSize: FontSize.s14),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey.withOpacity(0.2),
                ),
                widget.sessionModel.lessonMemorize == null ||
                        widget.sessionModel.lessonMemorize!.isEmpty
                    ? Container()
                    : lessonDetailsItem(
                        title: "التسميع",
                        sora: "${widget.sessionModel.lessonMemorize}"),
                widget.sessionModel.lessonMemorize == null ||
                        widget.sessionModel.lessonFarReview!.isEmpty
                    ? Container()
                    : lessonDetailsItem(
                        title: "المراجعه البعيده",
                        sora: "${widget.sessionModel.lessonFarReview}"),
                widget.sessionModel.lessonMemorize == null ||
                        widget.sessionModel.lessonNearReview!.isEmpty
                    ? Container()
                    : lessonDetailsItem(
                        title: "المراجعة القريبة ",
                        sora: "${widget.sessionModel.lessonNearReview}"),
                widget.sessionModel.lessonMemorize == null ||
                        widget.sessionModel.lessonTajweed!.isEmpty
                    ? Container()
                    : lessonDetailsItem(
                        title: "التجويد",
                        sora: "${widget.sessionModel.lessonTajweed}"),
                SizedBox(height: 20.h),
                widget.index == 0
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: LinearGradient(
                                begin: const Alignment(0.00, -1.00),
                                end: const Alignment(0, 1),
                                colors: [
                                  ColorManager.secondary,
                                  ColorManager.secondaryDark
                                ],
                              )),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.r)),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConstantRecordingAttendaceView(
                                      sessionId:"${widget.sessionModel.id}",
                                          // "c24a45cf-66a5-46e3-5663-08dc5d344e17",

                                    ),
                                  ),
                                );
                              },
                              child: const Text("تسجيل الحضور",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container lessonDetailsItem({
    required String title,
    required String sora,
  }) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          SizedBox(
            width: 200.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                sora,
                style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
    );
  }
}
