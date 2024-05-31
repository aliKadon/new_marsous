import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marsous1/models/test_student_model.dart';
import 'package:marsous1/screens/tests/test_details/controller/test_details_getx_controller.dart';

import 'package:shimmer/shimmer.dart';

import '../../../models/task_test_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../widgets/shimmer_loading/shimmer_loading_task_test_item.dart';
import '../../../widgets/test_Details_item.dart';

class TestDetailsView extends StatefulWidget {
  final int isSelected;
  final TaskTestModel taskModel;

  const TestDetailsView(
      {super.key, required this.isSelected, required this.taskModel});

  @override
  State<TestDetailsView> createState() => _TestDetailsViewState();
}

class _TestDetailsViewState extends State<TestDetailsView> {
  //CONTROLLER
  final TestDetailsGetxController _testDetailsGetxController =
      Get.put(TestDetailsGetxController());

  @override
  void initState() {
    _testDetailsGetxController.getTestStudentList(
        courseId: widget.taskModel.id!, pageIndex: 1, pageSize: 20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yMMMMEEEEd', 'ar')
            .format(DateTime.parse(widget.taskModel.date ?? "2024-04-18T15:15:00"))),
      ),
      body: WillPopScope(
        onWillPop: () async {
          _testDetailsGetxController.isLoading = true;
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
              GetBuilder<TestDetailsGetxController>(
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
                          itemCount: controller.testStudentList.length,
                          itemBuilder: (context, index) {
                            Get.put<TestStudentModel>(
                                controller.testStudentList[index],
                                tag: "${controller.testStudentList[index].id}");
                            return
                              // Text("${controller.testStudentList[index].grade}");
                              TestDetailsItem(
                              taskModel: widget.taskModel,
                              isSelected: widget.isSelected,
                              tag: "${controller.testStudentList[index].id}",
                              testStudentModel:
                                  controller.testStudentList[index],
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
