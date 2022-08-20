// ignore_for_file: avoid_print, unused_import, unnecessary_null_comparison, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

import '../../../data/theme/appTheme.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    CollectionReference users = firestore.collection('users');
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
      print(credential.user);
      try {
        await users
            .doc(credential.user!.email)
            .set({
              'bmi': 0,
              'uid': credential.user!.uid,
              'name': fullname,
              'email': credential.user!.email,
            })
            .then((value) => print("ok"))
            .catchError((error) => print("Failed to add bmi : $error"));
      } catch (e) {
        print(e);
      }

      Get.defaultDialog(
        title: 'Verification Email',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/images/repo.png')),
            Padding(padding: const EdgeInsets.only(bottom: 5)),
            Text(
                'we already send the email verification to $email , please check your email'),
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
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
          title: 'Failed',
          content: Column(
            children: [
              Container(child: Image.asset('assets/images/repo.png')),
              Padding(padding: const EdgeInsets.only(bottom: 5)),
              Text('sorry, the email is already in use by another user'),
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
