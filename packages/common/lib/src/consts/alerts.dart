import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
  static Future<void> showConfirmation({
    required BuildContext context,
    required String title,
    required String? message,
    String? confirmText,
    String? cancelText,
    required VoidCallback confirmAction,
    VoidCallback? cancelAction,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: Text(confirmText ?? 'CONFIRMAR'),
              onPressed: confirmAction,
            ),
            TextButton(
              child: Text(
                cancelText ?? 'CANCELAR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: cancelAction ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(title),
                content: message != null ? Text(message) : null,
                actions: [
                  TextButton(
                    onPressed: cancelAction ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(cancelText?.toUpperCase() ?? 'CANCELAR'),
                  ),
                  TextButton(
                    onPressed: confirmAction,
                    child: Text(confirmText?.toUpperCase() ?? 'CONFIRMAR'),
                  ),
                ],
              ));
    }
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String? message,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  static Future<void> showMessage({
    required BuildContext context,
    required String title,
    String? message,
    VoidCallback? action,
  }) async {
    if (Platform.isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: action ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              onPressed: action ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
