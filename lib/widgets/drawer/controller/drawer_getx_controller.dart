import 'package:get/get.dart';
import 'package:marsous1/data/api/controllers/marsous_info_api_controller.dart';
import 'package:marsous1/models/mobile_url_model.dart';

class DrawerGetXController extends GetxController {
  MarsousInfoApiController _apiController = MarsousInfoApiController();
  MobileUrlModel? mobileUrlModel;

  void getMobileUrl() async {
    try {
      mobileUrlModel = await _apiController.getMobileUrl();
      update();
    } catch (e) {
      print("get mobile url error : $e");
    }
  }
}
