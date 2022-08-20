// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HitungBmiController extends GetxController {
  var selectedGender = ''.obs;

  final bmiFormKey = GlobalKey<FormState>();

  late TextEditingController heightc, weightc, agec;
  var height = 0;
  var weight = 0;
  var age = 0;
  String bmiLabel = '';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onChangeGender(var gender) {
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
    CollectionReference userCalory = firestore.collection('userCalory');
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
      await userCalory
          .add({
            'height': height,
            'weight': weight,
            'age': age,
            'gender': selectedGender.toString(),
            'bmi': bmi,
            'bmi label': bmiLabel
          })
          .then((value) => print("ok"))
          .catchError((error) => print("Failed to add bmi : $error"));
    } catch (e) {
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
