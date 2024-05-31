import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


import '../../../models/api_response.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class UpdateProfileApiController with ApiHelper {
  Future<ApiResponse> updateProfileImage({required File file}) async {
    var url =
        Uri.parse("${ApiSettings.baseUrl}/Account/update-my-profile-image");
    var request = http.MultipartRequest(
      "POST",
      url,
    );
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      return ApiResponse(message: "File uploaded successfully!", status: 200);
    }
    return failedResponse;
  }

  Future<ApiResponse?> updateProfile({
    String? phoneNumber,
    String? country,
    String? firstName,
    String? middleName,
    String? lastName,
    String? state,
    String? city,
    String? addressDetails,
  }) async {
    var url = Uri.parse("${ApiSettings.baseUrl}/Account/update-my-profile");
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          "phoneNumber": phoneNumber,
          "firstName": firstName,
          "middleName": middleName,
          "lastName": lastName,
          "country": country,
          "state": state,
          "city": city,
          "addressDetails": addressDetails,
        },
      ),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["message"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }
}
