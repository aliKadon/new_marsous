import 'dart:convert';

import '../../../models/api_response.dart';
import '../../../notifications/firebase_messaging_service.dart';
import '../../../preferences/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

import '../api_helper.dart';
import '../api_settings.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String userName, required String password}) async {
    Uri uri = Uri.parse("${ApiSettings.baseUrl}/Account/login");
    var response = await http.post(uri,
        headers: headers,
        body: jsonEncode({
          'userName': userName,
          'password': password,
          // 'fcm_token': "asdasd",
          'fcm_token': await FirebaseMessagingService.instance.getToken(),
          'langCode': SharedPrefController().lang1,
        }));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        SharedPrefController().setToken(jsonResponse['data']);
        SharedPrefController().setPrimaryToken(jsonResponse['data']);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return failedResponse;
  }

  Future<ApiResponse?> forgetPassword({required String username}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Account/forgot-password?username=$username");
    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["message"], status: jsonData["status"]);
      }
    }
    return null;
  }

  Future<ApiResponse?> refreshFcm({required String newFcm}) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Account/reset-fcm-token?fcm_token=$newFcm");
    var response = await http.post(url, headers: headers);



    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["message"], status: jsonData["status"]);
      }
    }
    return null;
  }
}
