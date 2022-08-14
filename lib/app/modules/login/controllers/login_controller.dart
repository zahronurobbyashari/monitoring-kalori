import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  double headerHeight = 250;
  Key formKey = GlobalKey<FormState>();

  void login() {
    Get.toNamed(Routes.HITUNG_BMI);
  }

  void getRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  @override
  void onInit() {
    super.onInit();
    print("on init");
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

  void increment() => count.value++;
}
