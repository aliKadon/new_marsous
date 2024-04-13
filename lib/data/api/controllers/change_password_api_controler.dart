import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/api_response.dart';
import '../api_helper.dart';
import '../api_settings.dart';


class ChangePasswordApiController with ApiHelper {
  Future<ApiResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Account/change-my-password?OldPassword=$oldPassword&NewPassword=$newPassword");
    var response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
          message: jsonData["message"],
          status: jsonData["status"],
        );
      }
    }
    return failedResponse;
  }
}
