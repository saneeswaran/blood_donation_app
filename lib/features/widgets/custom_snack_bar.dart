import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

void successSnackBar({required String message, required BuildContext context}) {
  DelightToastBar(
    builder: (context) => ToastCard(
      color: Colors.white,
      title: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 3),
  ).show(context);
}

void failedSnackBar({required String message, required BuildContext context}) {
  DelightToastBar(
    builder: (context) => ToastCard(
      color: Colors.red,
      title: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    snackbarDuration: const Duration(seconds: 3),
    autoDismiss: true,
    position: DelightSnackbarPosition.top,
  ).show(context);
}

void warningSnackBar(String message, BuildContext context) {
  DelightToastBar(
    builder: (context) => ToastCard(
      color: Colors.orange,
      title: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    snackbarDuration: const Duration(seconds: 3),
    autoDismiss: true,
    position: DelightSnackbarPosition.top,
  ).show(context);
}
