import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShimmerLoadingStudentPageView extends StatelessWidget {
  const ShimmerLoadingStudentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 400.w,
            margin: EdgeInsets.only(top: 40.h),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 75.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.r))),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 40.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.r))),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 40.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.r))),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 15.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100.h,
                width: 100.w,
                // width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(55.r))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
