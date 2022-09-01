// ignore_for_file: unused_local_variable, non_constant_identifier_names, unnecessary_overrides, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var fullname = '';
  var email = '';
  var status_bmi = '';
  var berat_badan_ideal = '';
  var weight = '';

  void getUser() async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.email)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        fullname = documentSnapshot.get('name');
        email = documentSnapshot.get('email');
        status_bmi = documentSnapshot.get('bmi label');
        berat_badan_ideal =
            documentSnapshot.get('berat badan ideal').toString();
        weight = documentSnapshot.get('weight').toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
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
