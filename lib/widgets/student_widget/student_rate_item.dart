
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/app/utils/helpers.dart';
import 'package:marsous1/screens/lessons/controller/lesson_getx_controller.dart';

import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';

class StudentRateItem extends StatefulWidget {
  String title;
  final GlobalKey<FormState> formKey;

  StudentRateItem({required this.title, required this.formKey});

  @override
  State<StudentRateItem> createState() => _StudentRateItemState();
}

class _StudentRateItemState extends State<StudentRateItem> with Helpers {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonGetXController>(
      builder: (controller) => Form(
        key: widget.formKey,
        child: Container(
          child: Column(
            children: [
              ExpansionTile(
                title: Row(
                  children: [
                    Image.asset(ImageAssets.aboutUsStar, height: 20.h),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                children: widget.title == "التجويد"
                    ? [
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: TextFormField(
                            maxLines: 3,
                            onSaved: (newValue) {
                              controller.tajwidSurahTextEditingController.text =
                                  newValue!;
                            },
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "الرجاء ادخال المعلومات";
                            //   }
                            // },
                            controller:
                                controller.tajwidSurahTextEditingController,
                            decoration: const InputDecoration(
                              hintText: "السؤال",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ]
                    : [
                        controller.isLoading
                            ? showLoadingDialogNew()
                            : Padding(
                                padding: EdgeInsets.all(8.w),
                                child: CustomDropdown<String>.search(
                                  decoration: CustomDropdownDecoration(
                                      closedBorder:
                                          Border.all(color: Colors.grey)),
                                  hintText: 'اختر السورة',
                                  items: controller.suraListString,
                                  excludeSelected: false,
                                  onChanged: (value) {
                                    print('changing value to: $value');
                                    var index = controller.suraListString
                                        .indexOf(value!);
                                    print(
                                        "id of the surah : ${controller.surahList[index].id}");
                                    if (widget.title == "التسميع") {
                                      controller.memorizeSurahModel.surahId =
                                          index + 1;
                                    } else if (widget.title ==
                                        "المراجعة القريبة") {
                                      controller.nearReviewSurahModel.surahId =
                                          index + 1;
                                    } else if (widget.title ==
                                        "المراجعة البعيده") {
                                      controller.farReviewSurahModel.surahId =
                                          index + 1;
                                    }
                                  },
                                ),
                                // TextFormField(
                                //   decoration: const InputDecoration(
                                //     hintText: "اختر السورة",
                                //     hintStyle: TextStyle(color: Colors.grey),
                                //   ),
                                // ),
                              ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: TextFormField(
                                  onSaved: (newValue) {
                                    controller.fromSurahTextEditingController
                                        .text = newValue!;
                                    if (widget.title == "التسميع") {
                                      controller.memorizeSurahModel
                                              .startAyahNumber =
                                          int.parse(controller
                                              .fromSurahTextEditingController
                                              .text);
                                      // int.parse(newValue);
                                    } else if (widget.title ==
                                        "المراجعة القريبة") {
                                      controller.nearReviewSurahModel
                                              .startAyahNumber =
                                          int.parse(controller
                                              .fromSurahTextEditingController
                                              .text);
                                    } else if (widget.title ==
                                        "المراجعة البعيده") {
                                      controller.farReviewSurahModel
                                              .startAyahNumber =
                                          int.parse(controller
                                              .fromSurahTextEditingController
                                              .text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء ادخال المعلومات";
                                    }
                                  },
                                  controller:
                                      controller.fromSurahTextEditingController,
                                  decoration: const InputDecoration(
                                    hintText: "من",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                  color: Colors.red, fontSize: FontSize.s18),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: TextFormField(
                                  onSaved: (newValue) {
                                    controller.toSurahTextEditingController
                                        .text = newValue!;
                                    if (widget.title == "التسميع") {
                                      controller.memorizeSurahModel
                                              .endAyahNumber =
                                          int.parse(controller
                                              .toSurahTextEditingController
                                              .text);
                                    } else if (widget.title ==
                                        "المراجعة القريبة") {
                                      controller.nearReviewSurahModel
                                              .endAyahNumber =
                                          int.parse(controller
                                              .toSurahTextEditingController
                                              .text);
                                    } else if (widget.title ==
                                        "المراجعة البعيده") {
                                      controller.farReviewSurahModel
                                              .endAyahNumber =
                                          int.parse(controller
                                              .toSurahTextEditingController
                                              .text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء ادخال المعلومات";
                                    }
                                  },
                                  controller:
                                      controller.toSurahTextEditingController,
                                  decoration: const InputDecoration(
                                    hintText: "إلى",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.all(8.w),
                        //   child: TextFormField(
                        //     decoration: const InputDecoration(
                        //       hintText: "ملاحظات",
                        //       hintStyle: TextStyle(color: Colors.grey),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.all(8.w),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "التقيم",
                        //         style: TextStyle(
                        //             color: Colors.black38,
                        //             fontSize: FontSize.s14,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       const Spacer(),
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             mark++;
                        //           });
                        //         },
                        //         child: const Icon(Icons.add),
                        //       ),
                        //       SizedBox(width: 5.w),
                        //       Text(
                        //         "$mark",
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontSize: FontSize.s16,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       SizedBox(width: 5.w),
                        //       ElevatedButton(
                        //         style: const ButtonStyle(
                        //           backgroundColor: MaterialStatePropertyAll(
                        //             Color(0xFFF9F1E9),
                        //           ),
                        //         ),
                        //         onPressed: () {
                        //           setState(() {
                        //             mark--;
                        //           });
                        //         },
                        //         child: Image.asset(ImageAssets.minus, height: 25.h),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
