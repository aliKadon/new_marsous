import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../models/user_info_model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../screens/choose_center/controller/choose_center_api_controller.dart';


class ChooseAccountItem extends StatefulWidget {
  UserInfoModel userInfoModel;
  bool isSelect;

  ChooseAccountItem({super.key, required this.userInfoModel, required this.isSelect});

  @override
  State<ChooseAccountItem> createState() => _ChooseAccountItemState();
}

class _ChooseAccountItemState extends State<ChooseAccountItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseCenterGetXController>(
      builder: (controller) => Container(
        child: Row(
          children: [
            Image.asset(
              ImageAssets.accountProfileImage,
              height: 50.h,
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 190.w,
              child: Text("${widget.userInfoModel.fullName}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            Visibility(
                visible: widget.isSelect,
                child: Icon(
                  Icons.done_outline,
                  color: ColorManager.primary,
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
