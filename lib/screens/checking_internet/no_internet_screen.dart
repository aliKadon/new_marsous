import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/values_manager.dart';
import '../splash/splash_view.dart';

class NoInternetScreen extends StatelessWidget {
  bool _doubleBackToExitPressedOnce = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s20,
            ),
            Image.asset(
              ImageAssets.connectionLost,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Text(
                "لا يوجد اتصال بالانترنت, الرجاء التحقق من اتصالك بالانترنت",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.s14),
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            Container(
              width: AppSizeWidth.s206,
              height: AppSize.s60,
              child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SplashView(),
                    ));
                  },
                  child: const Text(
                    "حاول مجدداً",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }

    // _doubleBackToExitPressedOnce = true;
    // Get.snackbar(
    //   'تنبيه',
    //   'اضغط زر الرجوع مرة أخرى للخروج من التطبيق',
    //   backgroundColor: ColorManager.grey,
    //   borderRadius: 25.r,
    // );
    // // ScaffoldMessenger.of(context).showSnackBar(
    // //   SnackBar(
    // //       content: Text('Press back again to leave'),
    // //       backgroundColor: ColorManager.grey),
    // // );
    //
    // Timer(const Duration(seconds: 2), () {
    //   _doubleBackToExitPressedOnce = false;
    // });
    return false;
  }
}
