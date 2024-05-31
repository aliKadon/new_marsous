import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marsous1/models/get_task_student_model.dart';
import 'package:marsous1/models/session_model.dart';

import '../../../../app/utils/helpers.dart';
import '../../../../data/api/controllers/student_api_controller.dart';
import '../../../../models/api_response.dart';
import '../../../../resources/font_manager.dart';

class StudentHomeworkGetXController extends GetxController with Helpers {
  final StudentApiController _studentApiController = StudentApiController();
  late final GlobalKey<FormState> formKey = GlobalKey();

  ApiResponse? apiResponse;
  GetTaskStudentModel? getTaskStudentModel;
  var isLoading = true;

  String? answer;
  var file;
  var _progress = 0.0;

  void getTaskStudent({int? pageIndex, int? pageSize}) async {
    isLoading = true;
    try {
      getTaskStudentModel = await _studentApiController.getStudentTask(
          pageIndex: pageIndex, pageSize: pageSize);
      isLoading = false;
      update();
    } catch (e) {
      print("student - get task student erro : $e");
      isLoading = false;
      update();
    }
  }

  Future uploadTask({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf', 'png', 'jpg']);
      if (result != null) {
        file = File(result.paths.first!);
        // print("file path upload : $file");
        // fileBytes = await file!.readAsString(encoding:utf8);
      }

      /////////
      // final fileTemp = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (fileTemp == null) return;
      // file = File(fileTemp.path);

      update();
    } on PlatformException catch (e) {
      print('Failed to pick file: $e');
    }
  }

  void sendTask({
    required BuildContext context,
    required String sessionId,
  }) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    print("student - sendTask answer : $answer");
    try {
      showLoadingDialog(context: context, title: 'Loading...');
      apiResponse = await _studentApiController.sendTask(
          sessionId: sessionId, answer: answer, file: file);
      if (apiResponse!.status == 200) {
        Navigator.of(context).pop();
        showSnackBar(context, message: "${apiResponse?.message}", error: false);
      } else {
        Navigator.of(context).pop();
        showSnackBar(context, message: "${apiResponse?.message}", error: true);
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("student - send task error : $e");
    }
  }

  void downloadFile(
      {required SessionModel sessionModel, required BuildContext context}) {
    FileDownloader.downloadFile(
      notificationType: NotificationType.all,
      // url: sessionModel.taskFilePath!,
      url: "https://placebear.com/g/200/200",
      name: "${sessionModel.lessonTask} واجب",
      onDownloadError: (errorMessage) {
        // Navigator.of(context).pop();
        print("error message for downloading : $errorMessage");
        popUpProgressError(
          context: context,
        );
      },
      onDownloadCompleted: (path) {
        // Navigator.of(context).pop();
        File file = File(path);
        print("path file : $path");
        popUpProgressCompleted(context: context);
      },
      onProgress: (fileName, progress) {
        // Navigator.of(context).pop();
        _progress = progress;
        update();
        // setState(() {
        //
        // });
        // popUpProgress(
        //     context: context,
        //     progress: _progress.toString());
      },
    );
  }

  void popUpProgress(
      {required BuildContext context, required String progress}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(child: Text(progress));
      },
    );
  }

  void popUpProgressCompleted({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 200.w,
            height: 250.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done_outline,
                  color: Colors.green,
                  size: 100.h,
                ),
                Text("اكتمل التنزيل!!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
              ],
            ),
          ),
        );
      },
    );
  }

  void popUpProgressError({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 200.w,
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100.h,
                  color: Colors.red,
                ),
                Text("الرجاء المحاولة مجدداً !!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
