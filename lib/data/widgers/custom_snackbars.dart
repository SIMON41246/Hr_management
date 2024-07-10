import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBars {
  CustomSnackBars._();

  // - - - - - - - - - - - - - - - - - - SUCCESS SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static success(
      {required String title, required String message, int duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.green.shade600,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        overlayBlur: 1,
        icon: const Icon(
          Icons.done,
          color: Colors.white,
        ));
  }

  // - - - - - - - - - - - - - - - - - - ERROR SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static error(
      {required String title,
      required String message,
      int duration = 3,
      IconData? icon}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        overlayBlur: 1,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        icon: Icon(icon ?? Icons.error_outline, color: Colors.white));
  }

  // - - - - - - - - - - - - - - - - - - WARNING SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static warning(
      {required String title, required String message, int duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.black,
        backgroundColor: Colors.yellow.shade600,
        overlayBlur: 1,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        icon: const Icon(Icons.warning, color: Colors.white));
  }
}
