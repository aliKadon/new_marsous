import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';


import '../../app/utils/app_shared_data.dart';
import '../../notifications/firebase_messaging_service.dart';
import '../../notifications/local_notifications_service.dart';
import '../../preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../choose_account/choose_account_view.dart';
import '../login/controller/profile_getx_controller.dart';
import '../login/login_view.dart';
import '../main_rout/main_rout.dart';
import '../student_screens/main_student_rout/main_student_rout.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //controller
  final ProfileGetXController _profileGetXController =
      Get.put(ProfileGetXController());

  Timer? _timer;

  _startDelay() {
    _goNext();
  }

  _goNext() async {
    // init firebase.
    await Firebase.initializeApp();
    await FirebaseMessagingService.instance.init(context: context);
    await LocalNotificationsService.instance.init();

    SharedPrefController().getUserInfo();

    if (AppSharedData.userInfoModel != null) {
      _timer = Timer(const Duration(seconds: 3), () {

        //check the role of user
        if (AppSharedData.userInfoModel?.role == "Student") {
          // print("splash - user role : ${AppSharedData.userInfoModel?.isParent}");
          //if the user is parent
          if (AppSharedData.userInfoModel?.isParent == true) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ChooseAccountView(),
              ),
            );
          }else {
            // if student go to student screens
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainStudentRout(),
              ),
            );
          }
        } else if (AppSharedData.userInfoModel?.role == null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginView(),
          ));

        } else {
          // if not go to teacher screens
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainRout(),
            ),
          );
        }
      });
    } else {
      _timer = Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginView(),
        )),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageAssets.splashImage,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
