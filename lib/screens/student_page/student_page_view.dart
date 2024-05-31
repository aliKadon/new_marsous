import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/screens/student_page/controller/student_page_getx_controller.dart';
import 'package:marsous1/widgets/shimmer_loading/shimmer_loading_notification_item.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../widgets/shimmer_loading/shimmer_loading_student_page_view.dart';
import '../../widgets/student_widget/student_lesson_record_item.dart';
import '../../widgets/student_widget/student_test_record_item.dart';

class StudentPageView extends StatefulWidget {
  final String studentId;

  const StudentPageView({super.key, required this.studentId});

  @override
  State<StudentPageView> createState() => _StudentPageViewState();
}

class _StudentPageViewState extends State<StudentPageView> {
  int select = 0;
  List<bool> list = [false, true, true, false];
  List<bool> list1 = [false, false, true, true];

  //controller
  final StudentPageGetxController _studentPageGetxController =
      Get.put(StudentPageGetxController());

  @override
  void initState() {
    _studentPageGetxController.getStudentInfoSessionTest(
        studentId: widget.studentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<StudentPageGetxController>(
        builder: (controller) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                // color: Colors.red,
                gradient: LinearGradient(
                  begin: const Alignment(0.50, -1.00),
                  end: const Alignment(0, 1),
                  colors: [ColorManager.primary, Colors.white],
                ),
                image: const DecorationImage(
                    image: AssetImage(ImageAssets.loginMask), fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40.w, right: 20.w, left: 20.w, bottom: 20.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          "صفحة الطالب",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  controller.isLoading
                      ? getShimmerLoading()
                      : Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 400.w,
                                margin: EdgeInsets.only(top: 40.h),
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.w, right: 25.w, top: 75.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${controller.infoStudentSessionTestModel!.info!.fullName}",
                                          style: TextStyle(
                                              color: ColorManager.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: FontSize.s15),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: ColorManager.primary,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "${controller.infoStudentSessionTestModel!.info!.address}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize.s14),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              IconsAssets.loginEmailIcon,
                                              height: 20.h,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "${controller.infoStudentSessionTestModel!.info!.email}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize.s14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              // Expanded(
                                              //   child: Column(
                                              //     children: [
                                              //       Text(
                                              //         "1254",
                                              //         style: TextStyle(
                                              //             fontWeight:
                                              //                 FontWeight.w600,
                                              //             fontSize: FontSize.s16,
                                              //             color:
                                              //                 ColorManager.black),
                                              //       ),
                                              //       Text(
                                              //         "كود الطالب",
                                              //         style: TextStyle(
                                              //             color: ColorManager
                                              //                 .secondaryDark,
                                              //             fontSize: FontSize.s10,
                                              //             fontWeight:
                                              //                 FontWeight.w700),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              // const VerticalDivider(
                                              //   thickness: 1,
                                              //   color: Colors.grey,
                                              // ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${controller.infoStudentSessionTestModel!.info!.attendanceCount}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              FontSize.s16,
                                                          color: Colors.green),
                                                    ),
                                                    Text(
                                                      " ايام الحضور",
                                                      style: TextStyle(
                                                          color: ColorManager
                                                              .secondaryDark,
                                                          fontSize:
                                                              FontSize.s10,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${controller.infoStudentSessionTestModel!.info!.absenceCount}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              FontSize.s16,
                                                          color:
                                                              ColorManager.red),
                                                    ),
                                                    Text(
                                                      " ايام الغياب ",
                                                      style: TextStyle(
                                                          color: ColorManager
                                                              .secondaryDark,
                                                          fontSize:
                                                              FontSize.s10,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // const VerticalDivider(
                                              //   thickness: 1,
                                              //   color: Colors.grey,
                                              // ),
                                              // Expanded(
                                              //   child: Column(
                                              //     children: [
                                              //       Row(
                                              //         children: [
                                              //           Icon(Icons.star,
                                              //               color: ColorManager
                                              //                   .primary),
                                              //           Text(
                                              //             "(4.5)",
                                              //             style: TextStyle(
                                              //                 fontWeight:
                                              //                     FontWeight.w600,
                                              //                 fontSize:
                                              //                     FontSize.s16,
                                              //                 color: ColorManager
                                              //                     .primary),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       Text(
                                              //         "متوسط التقيمات",
                                              //         style: TextStyle(
                                              //             color: ColorManager
                                              //                 .secondaryDark,
                                              //             fontSize: FontSize.s8,
                                              //             fontWeight:
                                              //                 FontWeight.w900),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width * 0.5,
                                    padding: EdgeInsets.only(
                                        right: 20.w, left: 20.w),
                                    child: controller
                                                    .infoStudentSessionTestModel
                                                    ?.info
                                                    ?.image ==
                                                null ||
                                            controller
                                                .infoStudentSessionTestModel!
                                                .info!
                                                .image!
                                                .isEmpty
                                        ? Image.asset(
                                            ImageAssets.accountProfileImage,
                                            height: 100.h,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.r)),
                                            child: Image.network(
                                              fit: BoxFit.fill,
                                              controller
                                                  .infoStudentSessionTestModel!
                                                  .info!
                                                  .image!,
                                              height: 100.h,
                                              width: 100.w,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  ImageAssets.accountProfileImage,
                                                  height: 100.h,
                                                );
                                              },
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          select = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color:
                              select == 0 ? ColorManager.primary : Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          "سجل المنهج",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: select == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          select = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color:
                              select == 1 ? ColorManager.primary : Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          "سجل الاختبارات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: select == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Image.asset(
                    IconsAssets.homeworkIcon,
                    height: 23.h,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            controller.isLoading
                ? Expanded(
                    child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return getShimmerLoadingList();
                    },
                  ))
                : Expanded(
                    child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: select == 0
                        ? controller
                            .infoStudentSessionTestModel!.oldSessions!.length
                        : controller
                            .infoStudentSessionTestModel!.oldTests!.length,
                    padding: EdgeInsets.all(5.w),
                    itemBuilder: (context, index) {
                      return select == 1
                          ? StudentTestRecord(
                              testInfoModel: controller
                                  .infoStudentSessionTestModel!
                                  .oldTests![index],
                            )
                          : StudentLessonRecordItem(
                              sessionModel: controller
                                  .infoStudentSessionTestModel!
                                  .oldSessions![index],
                            );
                    },
                  ))
          ],
        ),
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ShimmerLoadingStudentPageView());
  }

  Shimmer getShimmerLoadingList() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const ShimmerLoadingNotificationItem());
  }
}
