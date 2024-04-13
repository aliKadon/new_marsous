import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marsous1/screens/constant_lesson/student_lesson_view.dart';


import '../../resources/color_manager.dart';
import '../../widgets/student_widget/contsant_student_rating_widget.dart';

class ConstantStudentRateView extends StatelessWidget {
  const ConstantStudentRateView({super.key});

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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const ConstantStudentRatingWidget(
                    title: "المراجعه البعيده",
                  ),
                  const ConstantStudentRatingWidget(
                    title: "المراجعة القريبة",
                  ),
                  const ConstantStudentRatingWidget(
                    title: "التسميع",
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.w),
                width: MediaQuery.of(context).size.width * 0.8,
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const StudentLessonView(),
                        ),
                      );
                    },
                    child: const Text("تأكيد",style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
