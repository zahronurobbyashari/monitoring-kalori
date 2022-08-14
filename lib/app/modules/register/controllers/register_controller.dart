import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  double headerHeight = 250;
  Key formKey = GlobalKey<FormState>();

  void getLogin() {
    Get.toNamed(Routes.HITUNG_BMI);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
