// ignore_for_file: avoid_print, unused_import, unnecessary_null_comparison, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  double headerHeight = 250;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailc, passwordc, fullnamec, confirmpasswordc;
  var email = '';
  var password = '';
  var fullname = '';
  var confirmPassword = '';

  // ignore: non_constant_identifier_names
  String? ValidateFullName(String value) {
    if (isWhiteSpace(value)) {
      return "this is a required field";
    } else {
      if (!isAlphabet(value)) {
        return "Please input alphabet only , no number or special character";
      } else if (value.length > 40) {
        return "maximum character for fullname  is 40";
      }
    }
    return null;
  }

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

  // ignore: non_constant_identifier_names
  String? ValidateConfirmPassword(String value) {
    if (isWhiteSpace(value)) {
      return "this is a required field";
    } else {
      if (value != passwordc.text) {
        return "confirm password must be same as password";
      }
    }
    return null;
  }

  bool isAlphabet(String value) {
    return RegExp(
      r"^[a-z ,.\'-]+$",
      caseSensitive: false,
    ).hasMatch(value);
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
        email: email.toString(),
        password: password.toString(),
      );
      await credential.user!.sendEmailVerification();
      //TODO: Make a Pop up Email verification Already Send

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emailc.dispose();
        print('The account already exists for that email.');
        //TODO: Make a Pop up Email Already exist
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
    fullnamec = TextEditingController();
    confirmpasswordc = TextEditingController();
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullnamec.clear();
    emailc.clear();
    passwordc.clear();
    confirmpasswordc.clear();
    super.onClose();
  }
}
