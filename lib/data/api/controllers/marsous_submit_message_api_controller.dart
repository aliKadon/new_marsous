import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../models/api_response.dart';
import '../../../models/submit_message_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class MarsousSubmitMessageApiController with ApiHelper {
  Future<ApiResponse> submitMessage(
      {required SubmitMessageModel submitMessageModel}) async {
    var url =
        Uri.parse("${ApiSettings.baseUrl}/Marsous/sbumit-message-to-marsous");
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        submitMessageModel.toJson(),
      ),
    );



    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return ApiResponse(
            message: jsonData["data"], status: jsonData["status"]);
      }
    }
    return failedResponse;
  }
}
