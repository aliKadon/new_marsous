import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/screens/tests/test_details/test_details_view.dart';


import '../../app/utils/app_shared_data.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../widgets/drawer/main_drawer.dart';
import '../../widgets/tests_item.dart';
import '../home/controller/home_getx_controller.dart';

class TestsView extends StatefulWidget {
  const TestsView({super.key});

  @override
  State<TestsView> createState() => _TestsViewState();
}

class _TestsViewState extends State<TestsView> {
  //controller
  final HomeGetXController _homeGetXController = Get.find<HomeGetXController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
      _homeGetXController.getTeacherCourses(pageIndex: page, pageSize: 20);
    }
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
                Row(
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
                          Text(
                            "${AppSharedData.userInfoModel?.fullName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeight.w600),
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
          GetBuilder<HomeGetXController>(
            builder: (controller) => Expanded(
              child: controller.testSessions.isEmpty
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
                      itemCount: controller.testSessions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TestDetailsView(
                                      sessionModel:
                                          controller.testSessions[index]),
                                ),
                              );
                            },
                            child: TestsItem(
                              sessionModel: controller.testSessions[index],
                            ));
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
