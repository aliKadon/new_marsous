import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/dialogs/loading_dialog_widget.dart';


mixin Helpers {
  // format date.
  static String formatDate(DateTime dateTime, {bool withTime = false}) {
    if (withTime) {
      return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
  }

  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  // show loading dialog.
  void showLoadingDialog({
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (_) => LoadingDialogWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }
}