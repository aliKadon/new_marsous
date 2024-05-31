import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/session_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../widgets/previous_lesson_details_item.dart';
import '../../../widgets/shimmer_loading/shimmer_loading_task_test_item.dart';
import '../../home/student_session_getx_controller/student_session_getx_controller.dart';

class ConstantPreviousLessonDetailsView extends StatefulWidget {
  final SessionModel sessionModel;
  final String sessionId;
  final int isSelected;

  const ConstantPreviousLessonDetailsView(
      {super.key,
      required this.sessionModel,
      required this.sessionId,
      required this.isSelected});

  @override
  State<ConstantPreviousLessonDetailsView> createState() =>
      _ConstantPreviousLessonDetailsViewState();
}

class _ConstantPreviousLessonDetailsViewState
    extends State<ConstantPreviousLessonDetailsView> {
  //controller
  final StudentSessionGetXController studentSessionGetXController =
      Get.put(StudentSessionGetXController());

  @override
  void initState() {
    //"817ee717-a117-4dfd-565e-08dc5d344e17"
    //"1c547486-01bd-4c77-5662-08dc5d344e17"
    print("session id : ${widget.sessionId}");
    studentSessionGetXController.getStudentSession(
        context: context, sessionId: widget.sessionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yMMMMEEEEd', 'ar')
            .format(DateTime.parse(widget.sessionModel.date!))),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
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
                            "المقرر",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s15,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('yMMMMEEEEd', 'ar').format(
                                DateTime.parse(widget.sessionModel.date!)),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.w,
                      ),
                      widget.sessionModel.lessonMemorize == null ||
                              widget.sessionModel.lessonMemorize!.isEmpty
                          ? Container()
                          : lessonDetailsItem(
                              title: "التسميع",
                              sora: "${widget.sessionModel.lessonMemorize}"),
                      widget.sessionModel.lessonFarReview == null ||
                              widget.sessionModel.lessonFarReview!.isEmpty
                          ? Container()
                          : lessonDetailsItem(
                              title: "المراجعه البعيده",
                              sora: "${widget.sessionModel.lessonFarReview}"),
                      widget.sessionModel.lessonNearReview == null ||
                              widget.sessionModel.lessonNearReview!.isEmpty
                          ? Container()
                          : lessonDetailsItem(
                              title: "المراجعه القريبة",
                              sora: "${widget.sessionModel.lessonNearReview}"),
                      widget.sessionModel.lessonTajweed == null ||
                              widget.sessionModel.lessonTajweed!.isEmpty
                          ? Container()
                          : lessonDetailsItem(
                              title: "التجويد",
                              sora: "${widget.sessionModel.lessonTajweed}"),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "الطلاب",
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w600,
              ),
            ),
            GetBuilder<StudentSessionGetXController>(
              builder: (controller) => controller.isLoading
                  ? Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return getShimmerLoading();
                      },
                    ))
                  : controller.teacherApiController.apiResponse!.status == 400
                      ? Expanded(
                          child: Center(
                          child: Text(
                              textAlign: TextAlign.center,
                              "${controller.teacherApiController.apiResponse!.message}\nلا يمكن عرض الطلاب الا قبل ساعة من بدء الجلسة"),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          itemCount: controller.studentSession.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Get.put<SessionModel>(
                                controller.studentSession[index],
                                tag: "${controller.studentSession[index].id}");
                            return PreviousLessonDetailsItem(
                              isSelected: widget.isSelected,
                              tag: "${controller.studentSession[index].id}",
                            );
                          },
                        )),
            )
          ],
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
          ),
        ],
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ShimmerLoadingTaskTestItem());
  }
}
