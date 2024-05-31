import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/screens/login/controller/profile_getx_controller.dart';
import 'package:marsous1/screens/student_screens/student_test/controller/student_test_getx_controller.dart';
import 'package:marsous1/screens/student_screens/student_test/student_test_details/student_test_details_view.dart';
import 'package:marsous1/widgets/shimmer_loading/shimmer_loading_notification_item.dart';
import 'package:marsous1/widgets/student_widget/test_student_item.dart';

import 'package:shimmer/shimmer.dart';

import '../../../app/utils/app_shared_data.dart';
import '../../../models/session_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../widgets/drawer/main_drawer.dart';
import '../../contact_us/contact_us_view.dart';

class StudentTestView extends StatefulWidget {
  const StudentTestView({super.key});

  @override
  State<StudentTestView> createState() => _StudentTestViewState();
}

class _StudentTestViewState extends State<StudentTestView> {
  //controller
  // final StudentHomeGetXController _studentHomeGetXController =
  //     Get.find<StudentHomeGetXController>();

  final StudentTestGetxController _studentTestGetxController =
      Get.put(StudentTestGetxController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // List<bool> listBool = [false, true, true, true];

  var isSelected = 0;
  final ScrollController _scrollController = ScrollController();
  var page = 1;
  var rows = 5;

  //check if it is the bottom of grid
  void scrollListener() {
    print('you in listner');
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("reached the bottom");
      print('page1 : ${page + 1}');
      page = page + 1;
      rows = rows + 5;
      // do something when you reach the bottom of the grid
      _studentTestGetxController.getTestStudent(pageIndex: page, pageSize: 20);
    }
  }

  @override
  void initState() {
    _studentTestGetxController.getTestStudent(pageIndex: 1, pageSize: 20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainDrawer(isStudent: true),
      body: GetBuilder<StudentTestGetxController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 15.h),
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                // color: Colors.red,
                gradient: LinearGradient(
                  begin: const Alignment(0.00, -1.00),
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
                  GetBuilder<ProfileGetXController>(
                    builder: (controller) => Row(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.only(
                                top: 50.h, right: 20.w, left: 20.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35.r),
                              child: AppSharedData.userInfoModel == null
                                  ? Image.asset(
                                      ImageAssets.accountProfileImage,
                                      height: 60.h,
                                      width: 60.h,
                                    )
                                  : Image.network(
                                      AppSharedData.userInfoModel!.image!,
                                      height: 60.h,
                                      width: 60.h,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          ImageAssets.accountProfileImage,
                                          height: 60.h,
                                          width: 60.h,
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "مرحبا بك",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s14),
                              ),
                              SizedBox(
                                width: 230.w,
                                child: Text(
                                  "${AppSharedData.userInfoModel?.fullName}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openEndDrawer();
                          },
                          icon: const Icon(Icons.view_headline_sharp),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Container(
                          height: 180.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: const DecorationImage(
                                image: AssetImage(
                                  ImageAssets.homeImage,
                                ),
                                fit: BoxFit.fill),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        top: 50.h,
                        start: 30.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 170.w,
                              child: Text(
                                "خيركم من تعلم القرآن وعلمه",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactUsView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "تواصل معنا",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.only(right: 12.w, left: 12.w),
                    child: Row(
                      children: [
                        Text(
                          "الاختبارات",
                          style: TextStyle(
                              fontSize: FontSize.s20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        Image.asset(
                          IconsAssets.homeworkIcon,
                          height: 23.h,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // controller.testSessions.isEmpty
            //     ? Expanded(
            //         child: ListView.builder(
            //           shrinkWrap: true,
            //           itemCount: 4,
            //           itemBuilder: (context, index) => getShimmerLoading(),))
            //     :
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 0;
                    });
                  },
                  child: Container(
                    height: 45.h,
                    width: 175.w,
                    decoration: BoxDecoration(
                        color: isSelected == 0
                            ? ColorManager.primary
                            : Colors.grey.withOpacity(0.1),
                        border: Border.all(
                          color: isSelected == 0
                              ? ColorManager.primary
                              : Colors.grey.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                        child: Text(
                      "الواجبات القادمة",
                      style: TextStyle(
                          color: isSelected == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.s14),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 1;
                    });
                  },
                  child: Container(
                    height: 45.h,
                    width: 175.w,
                    decoration: BoxDecoration(
                        color: isSelected == 1
                            ? ColorManager.primary
                            : Colors.grey.withOpacity(0.1),
                        border: Border.all(
                          color: isSelected == 1
                              ? ColorManager.primary
                              : Colors.grey.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                        child: Text(
                      "الواجبات السابقة",
                      style: TextStyle(
                          color: isSelected == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.s14),
                    )),
                  ),
                ),
              ],
            ),
            controller.isLoading
                ? Expanded(
                    child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return getShimmerLoading();
                    },
                  ))
                : isSelected == 1 &&
                        controller.getTestStudentModel!.oldTests!.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Text(
                          "لا يوجد اختبارات حاليا",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w700),
                        )),
                      )
                    : isSelected == 0 &&
                            controller
                                .getTestStudentModel!.upCommingTests!.isEmpty
                        ? Expanded(
                            child: Center(
                                child: Text(
                              "لا يوجد اختبارات حاليا",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeight.w700),
                            )),
                          )
                        : Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: isSelected == 0
                                  ? controller.getTestStudentModel!
                                      .upCommingTests!.length
                                  : controller
                                      .getTestStudentModel!.oldTests!.length,
                              itemBuilder: (context, index) {
                                Get.put<SessionModel>(
                                    isSelected == 0
                                        ? controller.getTestStudentModel!
                                            .upCommingTests![index]
                                        : controller.getTestStudentModel!
                                            .oldTests![index],
                                    tag:
                                        "${isSelected == 0 ? controller.getTestStudentModel!.upCommingTests![index].id : controller.getTestStudentModel!.oldTests![index].id}");
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentTestDetailsView(
                                          sessionModel: isSelected == 0
                                              ? controller.getTestStudentModel!
                                                  .upCommingTests![index]
                                              : controller.getTestStudentModel!
                                                  .oldTests![index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: TestStudentItem(
                                    isSelected: isSelected,
                                    sessionModel: isSelected == 0
                                        ? controller.getTestStudentModel!
                                            .upCommingTests![index]
                                        : controller.getTestStudentModel!
                                            .oldTests![index],
                                  ),
                                );
                              },
                            ),
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
        child: const ShimmerLoadingNotificationItem());
  }
}
