// ignore_for_file: avoid_print, unnecessary_overrides

import 'dart:async';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

import '../../login/controllers/login_controller.dart';

class SplashScreenController extends GetxController {
  final loginC = Get.put(LoginController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("on init");
  }

  @override
  void onReady() {
    super.onReady();

    print("on ready");
    loginC.isSignIn();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
