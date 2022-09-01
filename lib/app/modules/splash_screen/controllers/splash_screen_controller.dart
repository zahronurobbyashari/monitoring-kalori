// ignore_for_file: avoid_print, unnecessary_overrides, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable

import 'dart:async';

import 'package:get/get.dart';

import 'package:monitoring_kalori/app/routes/app_pages.dart';
import '../../commons/navigation_drawer/controllers/navigation_drawer_controller.dart';
import '../../login/controllers/login_controller.dart';

class SplashScreenController extends GetxController {
  int timer = 3;
  final navC = Get.put(NavigationDrawerController(), permanent: true);

  @override
  void onInit() {
    final loginC = Get.put(LoginController());

    navC;

    super.onInit();
    print("on init");
    if (loginC.isSignIn() == true) {
      print("Going to Routes Home in " + timer.toString() + " seconds");
      Timer(Duration(seconds: timer), () => {Get.offNamed(Routes.HOME)});
    } else {
      print("has no sign in");
      print("Going to Routes Login in " + timer.toString() + " seconds");
      print("userdata = " + loginC.auth.currentUser.toString());
      Timer(Duration(seconds: timer), () => {Get.offNamed(Routes.LOGIN)});
    }
  }

  @override
  void onReady() {
    super.onReady();
    print("on ready");
  }

  @override
  void onClose() {
    super.onClose();
  }
}
