import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/screens/login/controller/profile_getx_controller.dart';
import 'package:marsous1/screens/tests/controller/test_getx_controller.dart';
import 'package:marsous1/screens/tests/test_details/test_details_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/utils/app_shared_data.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../widgets/drawer/main_drawer.dart';
import '../../widgets/shimmer_loading/shimmer_loading_notification_item.dart';
import '../../widgets/tests_item.dart';

class TestsView extends StatefulWidget {
  const TestsView({super.key});

  @override
  State<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends State<TestsView> {
  //controller
  final TestGetxController _testGetxController = Get.put(TestGetxController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int isSelected = 0;

  final ScrollController _scrollController = ScrollController();
  var page = 1;
  var rows = 5;

  //check if it is the bottom of grid
  void scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      page = page + 1;
      rows = rows + 5;
      // do something when you reach the bottom of the grid
      _testGetxController.getTestList(pageIndex: page, pageSize: 20);
    }
  }

  @override
  void initState() {
    _testGetxController.getTestList(pageIndex: 1, pageSize: 20);
    super.initState();
  }

  List<bool> listBool = [false, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainDrawer(isStudent: false),
      body: Column(
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
                  builder:(controller) => Row(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.only(
                                top: 50.h, right: 20.w, left: 20.w),
                            child: AppSharedData.userInfoModel == null
                                ? Image.asset(
                                    ImageAssets.accountProfileImage,
                                    height: 60.h,
                                    width: 60.h,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(35.r),
                                    child: Image.network(
                                      AppSharedData.userInfoModel!.image!,
                                      // "http://marsous-001-site2.anytempurl.com/pImages/",
                                      height: 60.h,
                                      width: 60.h,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          ImageAssets.accountProfileImage,
                                          height: 60.h,
                                          width: 60.h,
                                        );
                                      },
                                    ),
                                  ),
                          )),
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
                                  color: Colors.black, fontSize: FontSize.s14),
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
          GetBuilder<TestGetxController>(
            builder: (controller) => controller.isLoading
                ? Expanded(
                    child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return getShimmerLoading();
                    },
                  ))
                : Expanded(
                    child: controller.testList == null
                        ? Center(
                            child: Text(
                            "لا يوجد اختبارات حاليا",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w700),
                          ))
                        : ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: isSelected == 0
                                ? controller.testList!.upcomming!.length
                                : controller.testList!.old!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TestDetailsView(
                                          isSelected: isSelected,
                                          taskModel: isSelected == 0
                                              ? controller
                                                  .testList!.upcomming![index]
                                              : controller
                                                  .testList!.old![index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: TestsItem(
                                    isSelected: isSelected,
                                    taskTestModel: isSelected == 0
                                        ? controller.testList!.upcomming![index]
                                        : controller.testList!.old![index],
                                  ));
                            },
                          ),
                  ),
          )
        ],
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
