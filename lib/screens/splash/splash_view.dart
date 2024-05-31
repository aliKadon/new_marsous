import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


import '../../app/utils/app_shared_data.dart';
import '../../notifications/firebase_messaging_service.dart';
import '../../notifications/local_notifications_service.dart';
import '../../preferences/shared_pref_controller.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/drawer/controller/drawer_getx_controller.dart';
import '../checking_internet/controller/checking_internet_controller.dart';
import '../checking_internet/no_internet_screen.dart';
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
  final CheckingInternetController _internetCheckerGetxController =
  Get.put(CheckingInternetController());
  final DrawerGetXController _drawerGetXController =
  Get.put(DrawerGetXController());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Timer? _timer;

  _startDelay() {
    _goNext();
  }

  _goNext() async {
    // init firebase.
    await Firebase.initializeApp();
    await FirebaseMessagingService.instance.init(context: context);
    await LocalNotificationsService.instance.init();
    if (SharedPrefController().enableNotifications) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }else {
      // FirebaseMessaging.onBackgroundMessage();
    }
    _drawerGetXController.getMobileUrl();

    SharedPrefController().getUserInfo();

    bool result = await InternetConnection().hasInternetAccess;

    if (result) {
      if (AppSharedData.userInfoModel != null) {
        _timer = Timer(const Duration(seconds: 3), () {

          //check the role of user
          if (AppSharedData.userInfoModel?.role == "Student") {
            //if the user is parent
            if (AppSharedData.userInfoModel?.isParent == true) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ChooseAccountView(),
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
          const Duration(milliseconds: 1500),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginView(),
          )),
        );
      }
    }else {
      print('No internet :( Reason:');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NoInternetScreen(),));
    }
    _internetCheckerGetxController.startMonitoringConnectivity(navigatorKey: navigatorKey);
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // on background.
  print("Handling a background message: ${message.messageId}");
}
