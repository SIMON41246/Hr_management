import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';



class CustomLoading {
  CustomLoading._();

  // - - - - - - - - - - - - - - - - - - START LOADING - - - - - - - - - - - - - - - - - -  //
  static Future<void> start() {
    return Get.defaultDialog(
        title: "Loading ...",
        titleStyle: Theme.of(Get.context!).textTheme.titleMedium,
        content: LottieBuilder.asset(
          Get.isDarkMode
              ? "C:\Users\moham\StudioProjects\mobile_app_rh\assets\loading_animation_dark.json"
              : "C:\Users\moham\StudioProjects\mobile_app_rh\assets\loading_animation_light.json",
          repeat: true,
          width: 90.0,
          height: 90.0,
        ),
        onWillPop: () async {
          return false;
        },
        titlePadding:
            const EdgeInsets.only(top: 12),
        contentPadding: EdgeInsets.zero,
        barrierDismissible: false);
  }

  // - - - - - - - - - - - - - - - - - - STOP LOADING - - - - - - - - - - - - - - - - - -  //
  static void stop() => Get.back();
}
