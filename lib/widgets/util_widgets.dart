import 'package:flutter/material.dart';

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

  static void createDialog(BuildContext context, String title, String content, Function onClick) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => onClick,
            ),
          ],
        );
      },
    );
  }

  static void createDismissibleDialog(BuildContext context, String title, String content, Function onClick) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => onClick,
            ),
          ],
        );
      },
    );
  }

}