// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DaftarMenuMakananController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getFoods() async {
    CollectionReference foods = firestore.collection('foods');

    return foods.get();
  }

  Stream<QuerySnapshot<Object?>> foods() {
    CollectionReference foods = firestore.collection('foods');

    return foods.snapshots();
  }

  @override
  void onInit() {
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
