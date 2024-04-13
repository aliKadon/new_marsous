import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../widgets/student_widget/student_rate_item.dart';
import '../homework/controller/homework_getx_controller.dart';

class StudentRateView extends StatefulWidget {
  const StudentRateView({super.key});

  @override
  State<StudentRateView> createState() => _StudentRateViewState();
}

class _StudentRateViewState extends State<StudentRateView> {
  //controller
  final HomeworkGetxController _homeworkGetxController = Get.put(
    HomeworkGetxController(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقيم  الطالب “ محمد عبد الله “"),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Image.asset(
                    ImageAssets.studentImage,
                    height: 50.h,
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "#255255 ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "محمد عبد الله عبد الله",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _homeworkGetxController.showSheetAddHomework(context);
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(50.r),
                  //           border: Border.all(color: Colors.white, width: 1),
                  //         ),
                  //         child: Icon(Icons.add, size: 15.h),
                  //       ),
                  //       SizedBox(width: 3.w),
                  //       const Text("واجب",style: TextStyle(color: Colors.white))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    StudentRateItem(title: "التسميع"),
                    StudentRateItem(title: "المراجعة القريبة"),
                    StudentRateItem(title: "المراجعة البعيده"),
                    StudentRateItem(title: "التجويد"),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.w),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                      begin: const Alignment(0.00, -1.00),
                      end: const Alignment(0, 1),
                      colors: [
                        ColorManager.secondary,
                        ColorManager.secondaryDark
                      ],
                    )),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)),
                    ),
                    onPressed: () {},
                    child: const Text("تأكيد",style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
