import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/session_model.dart';
import '../../../resources/font_manager.dart';
import '../../../widgets/previous_lesson_details_item.dart';
import '../../../widgets/shimmer_loading/shimmer_loading_task_test_item.dart';
import '../../home/student_session_getx_controller/student_session_getx_controller.dart';

class FlexPrevoiusLessonDetailsView extends StatefulWidget {
  final String episodeTitle;
  final String sessionId;
  final int isSelected;

  const FlexPrevoiusLessonDetailsView(
      {super.key,
      required this.episodeTitle,
      required this.sessionId,
      required this.isSelected});

  @override
  State<FlexPrevoiusLessonDetailsView> createState() =>
      _FlexPrevoiusLessonDetailsViewState();
}

class _FlexPrevoiusLessonDetailsViewState
    extends State<FlexPrevoiusLessonDetailsView> {
//controller
  final StudentSessionGetXController studentSessionGetXController =
      Get.put(StudentSessionGetXController());

  @override
  void initState() {
    //c550f6bd-f609-4ff1-5667-08dc5d344e17
    studentSessionGetXController.getStudentSession(
        context: context, sessionId: widget.sessionId);
    // studentSessionGetXController.getStudentSession(
    //     context: context, sessionId: "c550f6bd-f609-4ff1-5667-08dc5d344e17");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yMMMMEEEEd', 'ar')
            .format(DateTime.parse(widget.episodeTitle))),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "الطلاب",
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.s18,
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

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ShimmerLoadingTaskTestItem());
  }
}
