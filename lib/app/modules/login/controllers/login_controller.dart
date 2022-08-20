// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
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
          title: 'Verification Email',
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Image.asset('assets/images/repo.png')),
              Padding(padding: const EdgeInsets.only(bottom: 5)),
              Text(
                'we already send the email verification to $email , please check your email',
              ),
              Text('resend email ? '),
            ],
          ),
          confirm: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 5.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 1.0],
                colors: [appThemeData.primaryColor, appThemeData.accentColor],
              ),
              color: appThemeData.primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: FormHelper().buttonStyle(),
              onPressed: () async {
                await credential.user!.sendEmailVerification();
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  'ok'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          cancel: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 5.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 1.0],
                colors: [appThemeData.primaryColor, appThemeData.accentColor],
              ),
              color: appThemeData.primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: FormHelper().buttonStyle(),
              onPressed: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  'Back'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: 'Failed',
          content: Column(
            children: [
              Container(child: Image.asset('assets/images/repo.png')),
              Padding(padding: const EdgeInsets.only(bottom: 5)),
              Text('sorry, your account not registered or invalid'),
            ],
          ),
          confirm: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 5.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 1.0],
                colors: [appThemeData.primaryColor, appThemeData.accentColor],
              ),
              color: appThemeData.primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: FormHelper().buttonStyle(),
              onPressed: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  'ok'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: 'Failed',
          content: Column(
            children: [
              Container(child: Image.asset('assets/images/repo.png')),
              Padding(padding: const EdgeInsets.only(bottom: 5)),
              Text('incorrect password , please check your correct password'),
            ],
          ),
          confirm: Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 5.0,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 1.0],
                colors: [appThemeData.primaryColor, appThemeData.accentColor],
              ),
              color: appThemeData.primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: FormHelper().buttonStyle(),
              onPressed: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  'ok'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
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
    passwordc.clear();
    emailc.clear();
    super.onClose();
  }
}
