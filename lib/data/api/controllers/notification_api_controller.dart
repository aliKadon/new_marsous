import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../models/api_response.dart';
import '../../../models/notification_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class NotificationApiController with ApiHelper {
  // var sharedTokedChild = SharedPrefController().tokenChild;

  Future<List<NotificationModel>> getNotifications() async {

    var url = Uri.parse("${ApiSettings.baseUrl}/Marsous/get-my-notifications");
    var response = await http.get(url,
        headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return List<NotificationModel>.from(
          jsonData["data"].map(
            (x) => NotificationModel.fromJson(x),
          ),
        );
      }
    }
    return [];
  }

  Future<ApiResponse> makeNotificationAsRead({required String notiId}) async {

    var url = Uri.parse(
        "${ApiSettings.baseUrl}/Marsous/mark-notification-as-read?notiId=$notiId");
    var response = await http.post(
      url,
      headers: headers,
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
