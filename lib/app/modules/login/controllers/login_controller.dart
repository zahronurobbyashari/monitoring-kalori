// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  late TextEditingController emailc, passwordc;
  var email = '';
  var password = '';

  // ignore: non_constant_identifier_names
  String? ValidateEmail(String value) {
    if (isWhiteSpace(value)) {
      return "this is a required field";
    } else {
      if (!GetUtils.isEmail(value)) {
        return "please input a valid email";
      }
    }

    return null;
  }

  // ignore: non_constant_identifier_names
  String? ValidatePassword(String value) {
    if (isWhiteSpace(value)) {
      return "this is a required field";
    } else {
      if ((value.length < 8)) {
        return "character minimum of password is 8";
      } else if (value.length > 16) {
        return "maximum character for fullname  is 16";
      }
    }
    return null;
  }

  bool isWhiteSpace(String value) => value.trim().isEmpty;

  Future<void> checkLogin() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user!.emailVerified) {
        Get.offAllNamed(Routes.HITUNG_BMI);
      } else {
        Get.defaultDialog(
            title: "Verification Email",
            middleText: "Kamu belum verifikasi email.",
            content: const Text("Kirimkan kembali email"),
            onConfirm: () async {
              await credential.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: 'Ya',
            onCancel: () => Get.back(),
            textCancel: 'Kembali');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void getRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  @override
  void onInit() {
    super.onInit();
    print("on init");
    emailc = TextEditingController();
    passwordc = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    print("on ready");
  }

  @override
  void onClose() {
    emailc.dispose();
    passwordc.dispose();
    super.onClose();
  }
}
