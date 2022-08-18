import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController fullnamec = TextEditingController();
  TextEditingController confirmpassc = TextEditingController();
  double headerHeight = 250;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailc, passwordc;
  var email = '';
  var password = '';

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

  String? ValidatePassword(String value) {
    if (value.length < 8) {
      return "character minimum of password is 8";
    }
    return null;
  }

  bool isWhiteSpace(String value) => value.trim().isEmpty;

  Future<void> checkRegister() async {
    // ignore: unused_local_variable
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: emailc.value.toString(),
        password: passwordc.value.toString(),
      );
      await credential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: "Verification Email",
        middleText: "Kami telah mengirimkan email verifikasi ke $emailc .",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: 'yes',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emailc.dispose();
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void getLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    emailc = TextEditingController();
    passwordc = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullnamec.dispose();
    emailc.dispose();
    passwordc.dispose();
    confirmpassc.dispose();
    super.onClose();
  }
}
