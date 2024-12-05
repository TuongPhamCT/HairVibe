import 'package:flutter/material.dart';

import '../Theme/palette.dart';

abstract class UtilWidgets {

  // const title
  static const NOTIFICATION = "Notification";
  static const WARNING = "Warning";

  static void createLoadingWidget(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  static void createDialog(BuildContext context, String title, String content, VoidCallback onClick) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onClick,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void createDismissibleDialog(BuildContext context, String title, String content, VoidCallback onClick) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onClick,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void createSnackBar(BuildContext context, String content){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Palette.primary,
        content: Text(
          content,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

}