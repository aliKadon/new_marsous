import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/utils/helpers.dart';
import '../../../data/api/controllers/change_password_api_controler.dart';
import '../../../data/api/controllers/update_profile_api_controller.dart';
import '../../../data/api/controllers/user_details_api_controller.dart';
import '../../../models/api_response.dart';
import '../login_view.dart';

class ProfileGetXController extends GetxController with Helpers {
  final UserDetailsApiController _userDetailsApiController =
      UserDetailsApiController();
  final UpdateProfileApiController _updateProfileApiController =
      UpdateProfileApiController();
  final ChangePasswordApiController _changePasswordApiController =
      ChangePasswordApiController();

  final TextEditingController newPassword = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  File? image;
  String? base64;
  List<String> listImage = [];

  ApiResponse? userInfoModel;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country= TextEditingController();
  TextEditingController firstName= TextEditingController();
  TextEditingController middleName= TextEditingController();
  TextEditingController lastName= TextEditingController();
  TextEditingController addressDetails= TextEditingController();
  TextEditingController state= TextEditingController();
  TextEditingController city= TextEditingController();
  String? oldPassword;

  // String? newPassword;
  String? confirmPassword;

  void getMyInfo({required BuildContext context}) async {
    try {
      userInfoModel = await _userDetailsApiController.getMyInfo();
      update();
    } catch (e) {
      //if the token that saved in shared preferences expired go to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
      print("error getMyInfo function : $e");
    }
  }

  void changeProfileImage(
      {required BuildContext context, required File file}) async {
    try {
      showLoadingDialog(context: context, title: 'Logging...');
      final ApiResponse apiResponse =
          await _updateProfileApiController.updateProfileImage(file: file);
      if (apiResponse.status == 200) {
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse.message, error: false);
      } else {
        Navigator.of(context).pop();
        showSnackBar(context, message: apiResponse.message, error: true);
      }
    } catch (e) {
      Navigator.of(context).pop();

      showSnackBar(context, message: e.toString(), error: true);
    }
  }

  Future pickImage({required BuildContext context}) async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 == null) return;
      final imageTemp = File(image1.path);
      image = imageTemp;
      List<int> byts = (await image!.readAsBytes());
      base64 = base64Encode(byts);
      listImage.add('data:image/jpeg;base64,$base64');
      changeProfileImage(context: context, file: imageTemp);
      ApiResponse userInfo = await _userDetailsApiController.getMyInfo();
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void updateProfile({required BuildContext context}) async {
    showLoadingDialog(context: context, title: 'Logging...');
    try{
      userInfoModel = await _updateProfileApiController.updateProfile(
        phoneNumber: phoneNumber.text,
        lastName: lastName.text,
        firstName: firstName.text,
        addressDetails: addressDetails.text,
        middleName: middleName.text,
        city: "",
        state: "",
        country: "",
      );
      if (userInfoModel!.status == 200) {
        getMyInfo(context: context);
        Navigator.of(context).pop();
        showSnackBar(context, message: userInfoModel!.message, error: false);
      }else {
        Navigator.of(context).pop();
        showSnackBar(context, message: userInfoModel!.message, error: true);
      }

      update();
    }catch (e) {
      print("update profile _ error : $e");
      Navigator.of(context).pop();
      showSnackBar(context, message: userInfoModel!.message, error: true);
    }
  }

  void changePassword({required BuildContext context}) async {
    try {
      if (!formKey.currentState!.validate()) return;
      formKey.currentState!.save();
      showLoadingDialog(context: context, title: 'Logging...');
      userInfoModel = await _changePasswordApiController.changePassword(
          oldPassword: oldPassword!, newPassword: newPassword.text);
      if (userInfoModel!.status == 200) {
        Navigator.of(context).pop();
        showSnackBar(context, message: userInfoModel!.message, error: false);
      } else {
        Navigator.of(context).pop();
        showSnackBar(context, message: userInfoModel!.message, error: true);
      }
    } catch (e) {
      Navigator.of(context).pop();
      showSnackBar(context, message: e.toString(), error: true);
    }
  }
}
