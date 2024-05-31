import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marsous1/app/utils/helpers.dart';
import 'package:marsous1/data/api/controllers/auth_api_controller.dart';
import 'package:marsous1/models/api_response.dart';

class NotificationSettingGetxController extends GetxController with Helpers{
  final AuthApiController _apiController = AuthApiController();
  ApiResponse? apiResponse;

  void refreshFcm({required String newFcm,required BuildContext context}) async {
    showLoadingDialog(context: context,title: "loading");
    try {
      apiResponse = await _apiController.refreshFcm(newFcm: newFcm);
      print("notification - refresh fcm : ${apiResponse?.status}");
      Navigator.of(context).pop();
      update();
    } catch (e) {
      print("notification - refresh fcm error : $e");
      Navigator.of(context).pop();
    }
  }
}
