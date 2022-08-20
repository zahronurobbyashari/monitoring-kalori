// ignore_for_file: avoid_print, unnecessary_overrides

import 'dart:async';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

import '../../login/controllers/login_controller.dart';

class SplashScreenController extends GetxController {
  // ignore: todo
  //TODO: Implement SplashScreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("on init");
  }

  @override
  void onReady() {
    int timer = 3;
    super.onReady();
    print("on ready");
    print("Going to Routes Login in " + timer.toString() + "seconds");
    Timer(Duration(seconds: timer), () => {Get.offNamed(Routes.LOGIN)});
  }

  @override
  void onClose() {
    super.onClose();
  }
}
