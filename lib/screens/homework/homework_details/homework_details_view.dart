import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/task_test_model.dart';
import 'package:marsous1/models/task_student_model.dart';
import 'package:marsous1/screens/homework/homework_details/controller/homework_details_getx_controller.dart';

import 'package:shimmer/shimmer.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../widgets/homework_details_item.dart';
import '../../../widgets/shimmer_loading/shimmer_loading_task_test_item.dart';
import '../../home/student_session_getx_controller/student_session_getx_controller.dart';

class HomeworkDetailsView extends StatefulWidget {
  final TaskTestModel taskModel;
  final int isSelected;

  const HomeworkDetailsView(
      {super.key, required this.taskModel,required this.isSelected});

  @override
  State<HomeworkDetailsView> createState() => _HomeworkDetailsViewState();
}

class _HomeworkDetailsViewState extends State<HomeworkDetailsView> {
  //CONTROLLER
  final StudentSessionGetXController _studentSessionGetXController =
      Get.put(StudentSessionGetXController());
  final HomeworkDetailsGetxController _homeworkDetailsGetxController =
      Get.put(HomeworkDetailsGetxController());

  @override
  void initState() {
    _homeworkDetailsGetxController.getTaskStudentList(
        courseId: widget.taskModel.id!, pageSize: 20, pageIndex: 1);
    super.initState();
  }

  List<bool> list = [true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat('yMMMMEEEEd', 'ar')
              .format(DateTime.parse(widget.taskModel.date!))),
        ),
        body: WillPopScope(
          onWillPop: () async {
            _homeworkDetailsGetxController.isLoading = true;
            Navigator.of(context).pop();

            return false;
          },
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(15.r))),
                //   child: Padding(
                //     padding: EdgeInsets.all(8.w),
                //     child: Row(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(5.w),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFFF9F1E9),
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(10.r),
                //             ),
                //           ),
                //           child:
                //               Image.asset(IconsAssets.searchIcon, height: 23.h),
                //         ),
                //         SizedBox(
                //           width: 300.w,
                //           child: TextFormField(
                //             decoration: InputDecoration(
                //               hintText: "بحث بإسم الطالب / كود الطالب",
                //               hintStyle: TextStyle(
                //                   color: Colors.grey, fontSize: FontSize.s14),
                //               focusedBorder: InputBorder.none,
                //               disabledBorder: InputBorder.none,
                //               enabledBorder: InputBorder.none,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageAssets.aboutUsStar,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 300.w,
                        child: Text(
                          "${widget.taskModel.question}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "الطلاب",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GetBuilder<HomeworkDetailsGetxController>(
                  builder: (controller) => controller.isLoading == true
                      ? Expanded(
                          child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return getShimmerLoading();
                          },
                        ))
                      : Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.taskStudentList.length,
                            itemBuilder: (context, index) {
                              Get.put<TaskStudentModel>(
                                  controller.taskStudentList[index],
                                  tag:
                                      "${controller.taskStudentList[index].id}");
                              return HomeworkDetailsItem(
                                taskModel: widget.taskModel,
                                isSelected: widget.isSelected,
                                tag: "${controller.taskStudentList[index].id}",
                                taskStudentModel: controller.taskStudentList[index],
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
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
