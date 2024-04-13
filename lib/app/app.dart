import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../resources/theme_manager.dart';
import '../screens/splash/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        // final provider = Provider.of<LocaleProvider>(context);
        // print(provider.locale);

        // var isArabic = SharedPrefController().lang1;
        // print('isArabic : $isArabic');
        // print(_profileGetxController.language);

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
            theme:
            getApplicationTheme()
          );
      },
    );
  }
}