import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HitungBmiController extends GetxController {
  //TODO: Implement HitungBmiController

  final count = 0.obs;
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

  void calcBMI() async {
    CollectionReference userBMI = firestore.collection('bmi');
    final isValid = bmiFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    bmiFormKey.currentState!.save();
    print("height : " + height.toString());
    print("weight : " + weight.toString());
    print("age : " + age.toString());
    print(selectedGender);
    double bmi = weight / pow(height / 100, 2);
    print(bmi);
    if (bmi == 0 && bmi <= 15.0)
      bmiLabel = "terlalu sangat kurus";
    else if (bmi >= 15.0 && bmi <= 16.0)
      bmiLabel = "sangat kurus";
    else if (bmi >= 16.0 && bmi <= 18.5)
      bmiLabel = "kurus";
    else if (bmi >= 18.5 && bmi <= 25.0)
      bmiLabel = "normal";
    else if (bmi >= 25.0 && bmi <= 30.0)
      bmiLabel = "gemuk";
    else if (bmi >= 30.0 && bmi <= 35.0)
      bmiLabel = "cukup gemuk";
    else if (bmi >= 35.0 && bmi <= 40.0)
      bmiLabel = "sangat gemuk";
    else
      bmiLabel = "obesitas";
    try {
      await userBMI
          .add({
            'height': heightc.text,
            'weight': weightc.text,
            'age': agec.text,
            'gender': selectedGender.toString(),
            'bmi': bmi,
            'bmi label': bmiLabel
          })
          .then((value) => print("User Added"))
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

  void increment() => count.value++;
}
