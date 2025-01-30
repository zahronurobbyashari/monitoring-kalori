// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, nullable_type_in_catch_clause, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, unnecessary_overrides

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';
//import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../data/theme/appTheme.dart';

class HitungBmiController extends GetxController {
  var selectedGender = ''.obs;

  final bmiFormKey = GlobalKey<FormState>();

  late TextEditingController heightc, weightc, agec;
  var height = 0;
  var weight = 0;
  var age = 0;
  var bmi = 0.0;
  var actLevel = 1.2.obs;
  var berat_badan_ideal = 0.0;
  var dailyCaloriesNeeds = 0.0.obs;
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

  double calculateBMI() {
    if (height > 0) {
      return weight / pow(height / 100, 2);
    } else {
      return 0.0;
    }
  }

  double calculateBMR() {
    if (selectedGender.value == 'male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
  }

  double calculateDailyCaloricNeeds() {
    double bmr = calculateBMR();
    return bmr * actLevel.value;
  }

  void calcBMI() async {
    CollectionReference users = firestore.collection('users');
    final isValid = bmiFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    bmiFormKey.currentState!.save();

    bmi = calculateBMI();
    double bmr = calculateBMR();
    dailyCaloriesNeeds.value = calculateDailyCaloricNeeds();

    if (bmi >= 0 && bmi <= 15.0) {
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

    berat_badan_ideal = selectedGender.value == 'male'
        ? (height - 100) - ((height - 100) * 10 / 100)
        : (height - 100) - ((height - 100) * 15 / 100);

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
              'bmi label': bmiLabel,
              'berat badan ideal': berat_badan_ideal,
              'dailyCaloriesNeeds': dailyCaloriesNeeds.value,
            },
            SetOptions(merge: true),
          )
          .then((value) => print("Data BMI berhasil ditambahkan"))
          .catchError((error) => print("Gagal menambahkan BMI : $error"));
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/images/repo.png')),
            Padding(padding: const EdgeInsets.only(bottom: 5)),
            Text(
                "Maaf, kami tidak dapat memproses permintaan Anda. Silakan coba lagi nanti"),
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
              colors: [
                appThemeData.primaryColor,
                appThemeData.colorScheme.secondary
              ],
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
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.email)
          .get();

      if (document.exists) {
        dailyCaloriesNeeds = document['dailyCaloriesNeeds'] ?? 0.0;
        update(); // Perbarui state GetX setelah mendapatkan data
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
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
