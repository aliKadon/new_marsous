import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/utils/app_shared_data.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../login/controller/profile_getx_controller.dart';

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
  void initState() {
    _profileGetXController.phoneNumber.text =
        AppSharedData.userInfoModel!.phoneNumber!;
    _profileGetXController.firstName.text =
        AppSharedData.userInfoModel!.firstName!;
    _profileGetXController.middleName.text =
        AppSharedData.userInfoModel!.middleName!;
    _profileGetXController.lastName.text =
        AppSharedData.userInfoModel!.lastName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        //update the image in the home page
        _profileGetXController.getMyInfo(context: context);
        AppSharedData.userInfoModel;
        _profileGetXController.update();
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => MainStudentRout(index: 0,),
        // ));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              // height: 530.h,
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
                          onPressed: () {
                            _profileGetXController.getMyInfo(context: context);
                            AppSharedData.userInfoModel;
                            _profileGetXController.update();
                            Navigator.of(context).pop();
                            // Navigator.of(context)
                            //     .pushReplacement(MaterialPageRoute(
                            //   builder: (context) => MainStudentRout(index: 0,),
                            // ));
                          },
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
                    // height: 390.h,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            // height: 470.h,
                            padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                bottom: 10.w,
                                top: 40.w),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 25.w,
                                    right: 25.w,
                                    top: 75.h,
                                    bottom: 20.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextFormField(
                                      controller: _profileGetXController.firstName,
                                      onSaved: (newValue) {
                                        _profileGetXController.firstName.text =
                                            newValue!;
                                      },
                                      decoration: InputDecoration(
                                        label: const Text("الاسم الأول"),
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
                                      controller: _profileGetXController.middleName,
                                      onSaved: (newValue) {
                                        _profileGetXController.middleName.text =
                                            newValue!;
                                      },
                                      decoration: InputDecoration(
                                        label: const Text("اسم الأب"),
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
                                      controller: _profileGetXController.lastName,
                                      onSaved: (newValue) {
                                        _profileGetXController.lastName.text =
                                            newValue!;
                                      },
                                      decoration: InputDecoration(
                                        label: Text("اسم العائلة"),
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
                                      controller:
                                          _profileGetXController.phoneNumber,
                                      onSaved: (newValue) {
                                        _profileGetXController
                                            .phoneNumber.text = newValue!;
                                      },
                                      decoration: InputDecoration(
                                        label: Text("رقم الهاتف"),
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
                                      enabled: false,
                                      decoration: InputDecoration(
                                        label: Text(
                                            "${AppSharedData.userInfoModel?.email}"),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
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
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        label: Text(
                                            "${AppSharedData.userInfoModel?.userName}"),
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
                                child: AppSharedData.userInfoModel?.image ==
                                        null
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
                              _profileGetXController.pickImage(
                                  context: context);
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
            // ElevatedButton(
            //   onPressed: () {
            //     SharedPrefController().logout();
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) => const LoginView(),
            //       ),
            //     );
            //   },
            //   child: const Text("تسجيل الخروج"),
            // ),
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
                        onPressed: () {
                          _profileGetXController.updateProfile(
                              context: context);
                        },
                        child: const Text(
                          "حفظ",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
