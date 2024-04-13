import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../models/marsous_info_model.dart';
import '../api_helper.dart';
import '../api_settings.dart';

class MarsousInfoApiController with ApiHelper {
  Future<MarsousInfoModel?> getMarousInfo() async {
    var url = Uri.parse("${ApiSettings.baseUrl}/Marsous/get-marsous-info");
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData["status"] == 200) {
        return MarsousInfoModel.fromJson(jsonData["data"]);
      }
    }
    return null;
  }
}
