// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, nullable_type_in_catch_clause, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

import '../../../data/theme/appTheme.dart';

class HitungBmiController extends GetxController {
  var selectedGender = ''.obs;

  final bmiFormKey = GlobalKey<FormState>();

  late TextEditingController heightc, weightc, agec;
  var height = 0;
  var weight = 0;
  var age = 0;
  var bmi = 0;
  String bmiLabel = '';

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void onChangeGender(var gender) {
    assert(gender != null);
    selectedGender.value = gender;
    print(selectedGender.value);
  }

  String? Validates(String value) {
    if (isWhiteSpace(value)) {
      return "this is a required field";
    }
    return null;
  }

  bool isWhiteSpace(String value) => value.trim().isEmpty;

  void calcBMI() async {
    CollectionReference users = firestore.collection('users');
    final isValid = bmiFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    bmiFormKey.currentState!.save();

    double bmi = weight / pow(height / 100, 2);

    if (bmi == 0 && bmi <= 15.0) {
      bmiLabel = "terlalu sangat kurus";
    } else if (bmi >= 15.0 && bmi <= 16.0) {
      bmiLabel = "sangat kurus";
    } else if (bmi >= 16.0 && bmi <= 18.5) {
      bmiLabel = "kurus";
    } else if (bmi >= 18.5 && bmi <= 25.0) {
      bmiLabel = "normal";
    } else if (bmi >= 25.0 && bmi <= 30.0) {
      bmiLabel = "gemuk";
    } else if (bmi >= 30.0 && bmi <= 35.0) {
      bmiLabel = "cukup gemuk";
    } else if (bmi >= 35.0 && bmi <= 40.0) {
      bmiLabel = "sangat gemuk";
    } else {
      bmiLabel = "obesitas";
    }
    try {
      await users
          .doc(auth.currentUser!.email)
          .set(
            {
              'height': height,
              'weight': weight,
              'age': age,
              'gender': selectedGender.toString(),
              'bmi': bmi,
              'bmi label': bmiLabel
            },
            SetOptions(merge: true),
          )
          .then((value) => print("ok"))
          .catchError((error) => print("Failed to add bmi : $error"));
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.defaultDialog(
        title: 'Something wrong',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/images/repo.png')),
            Padding(padding: const EdgeInsets.only(bottom: 5)),
            Text(
                "sorry, we can't processing your request. please try again later "),
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
      print(e);
    }
  }

  void statusBMI() {}

  @override
  void onInit() {
    super.onInit();
    print("on init");
    heightc = TextEditingController();
    weightc = TextEditingController();
    agec = TextEditingController();
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
