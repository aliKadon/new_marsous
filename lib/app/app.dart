import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/screens/checking_internet/controller/checking_internet_controller.dart';

import '../resources/theme_manager.dart';
import '../screens/splash/splash_view.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CheckingInternetController _internetCheckerGetxController =
  Get.put(CheckingInternetController());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    _internetCheckerGetxController.checkInternetConnectivity();
    _internetCheckerGetxController.startMonitoringConnectivity(navigatorKey: navigatorKey);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        // final provider = Provider.of<LocaleProvider>(context);

        // var isArabic = SharedPrefController().lang1;


        return GetMaterialApp(
            // navigatorKey: navigatorKey,

            locale: const Locale('ar','AR'),
            // locale: DevicePreview.locale(context),
            // locale: provider.locale,
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            // onGenerateRoute: RouteGenerator.getRoute,
            // initialRoute: Routes.splashRoute,
            home: const SplashView(),
            navigatorKey: navigatorKey,
            theme:
            getApplicationTheme()
          );
      },
    );
  }
}