import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marsous1/app/utils/helpers.dart';
import 'package:marsous1/data/api/controllers/auth_api_controller.dart';
import 'package:marsous1/models/api_response.dart';

class ForgetPasswordGetxController extends GetxController with Helpers {
  ApiResponse? apiResponse;
  final AuthApiController _apiController = AuthApiController();
  TextEditingController emailOrUserNameTextController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  void forgetPassword({required BuildContext context}) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    showLoadingDialog(
      context: context,
      title: "Loading",
    );
    try {
      apiResponse = await _apiController.forgetPassword(
          username: emailOrUserNameTextController.text);
      Navigator.of(context).pop();
      if (apiResponse!.status == 200) {
        showSnackBar(context, message: apiResponse!.message);
      } else {
        showSnackBar(context, message: apiResponse!.message, error: true);
      }
      update();
    } catch (e) {
      print("forget password - error: $e");
      Navigator.of(context).pop();
    }
  }
}
