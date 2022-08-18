import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailc = TextEditingController();
  final passc = TextEditingController();

  Key formKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
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
  }

  @override
  void onReady() {
    super.onReady();
    print("on ready");
  }

  @override
  void onClose() {
    emailc.dispose();
    passc.dispose();
    super.onClose();
  }
}
