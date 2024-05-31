import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../app/utils/app_shared_data.dart';
import '../../../models/api_response.dart';
import '../../../models/user_info_model.dart';
import '../../../preferences/shared_pref_controller.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class UserDetailsApiController with ApiHelper {
  var sharedTokedChild = SharedPrefController().tokenChild;

  Future<ApiResponse> getMyInfo() async {

    var url = Uri.parse("${ApiSettings.baseUrl}/Account/get-my-info");
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonData["data"]);
        //save user info in shared preferences
        SharedPrefController().saveUserInfo(userInfoModel: userInfoModel);
        AppSharedData.userInfoModel = userInfoModel;
        print(
            "get my info - updated image : ${AppSharedData.userInfoModel!.image}");
        return ApiResponse(
            message: jsonData["message"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }

  Future<ApiResponse> getMyInfoPrimary() async {

    var url = Uri.parse("${ApiSettings.baseUrl}/Account/get-my-info");
    var response = await http.get(url, headers: headersPrimary);

    // print("get my info body: ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonData["data"]);
        //save user info in shared preferences
        SharedPrefController().saveUserInfo(userInfoModel: userInfoModel);
        AppSharedData.userInfoModel = userInfoModel;
        return ApiResponse(
            message: jsonData["message"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }
}
