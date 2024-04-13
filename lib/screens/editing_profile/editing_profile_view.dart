import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/utils/app_shared_data.dart';
import '../../preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../login/controller/profile_getx_controller.dart';
import '../login/login_view.dart';

class EditingProfileView extends StatefulWidget {
  const EditingProfileView({super.key});

  @override
  State<EditingProfileView> createState() => _EditingProfileViewState();
}

class _EditingProfileViewState extends State<EditingProfileView> {
  //controller
  final ProfileGetXController _profileGetXController =
  Get.find<ProfileGetXController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 530.h,
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
                        "تعديل الصفحة الشخصية",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 390.h,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 370.h,
                          padding: EdgeInsets.only(left: 10.w,right: 10.w),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25.w, right: 25.w, top: 75.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text("الاسم"),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        child: Image.asset(IconsAssets.user,
                                            color: ColorManager.primary,
                                            height: 5.h,
                                            width: 5.w),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text("رقم الهاتف"),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        child: Image.asset(IconsAssets.call,
                                            color: ColorManager.primary,
                                            height: 5.h,
                                            width: 5.w),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text("البريد الالكتروني"),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        child: Image.asset(
                                            IconsAssets.loginEmailIcon,
                                            color: ColorManager.primary,
                                            height: 5.h,
                                            width: 5.w),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text("اسم المستخدم"),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            right: 10.w, left: 10.w),
                                        child: Image.asset(IconsAssets.user,
                                            color: ColorManager.primary,
                                            height: 5.h,
                                            width: 5.w),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<ProfileGetXController>(
                        builder: (controller) => Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.only(
                              right: 20.w,
                              left: 20.w,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: AppSharedData.userInfoModel?.image == null
                                  ? Image.asset(
                                ImageAssets.accountProfileImage,
                                height: 100.h,
                              )
                                  : controller.base64 != null
                                  ? Image.memory(
                                base64Decode(
                                  controller.base64!,
                                ),
                                height: 90,
                                width: 90,
                                fit: BoxFit.fill,
                              )
                                  : Image.network(
                                AppSharedData.userInfoModel!.image!,
                                height: 90,
                                width: 90,
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
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () {
                            _profileGetXController.pickImage(context: context);
                          },
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.only(
                                top: 60.w, right: 20.w, left: 100.w),
                            child: Image.asset(
                              IconsAssets.edit2,
                              height: 30.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              SharedPrefController().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            child: const Text("تسجيل الخروج"),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                      onPressed: () {},
                      child: const Text("حفظ")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
