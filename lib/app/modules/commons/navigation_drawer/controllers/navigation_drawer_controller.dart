// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var fullname = '';
  var email = '';

  void getUser() async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.email)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        print("name = " + documentSnapshot.get('name'));
        fullname = documentSnapshot.get('name');
        email = documentSnapshot.get('email');
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
