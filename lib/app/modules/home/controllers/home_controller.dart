// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/modules/commons/navigation_drawer/controllers/navigation_drawer_controller.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var gram = 14.toString();
  final navC = Get.put(NavigationDrawerController());

  Future<QuerySnapshot<Object?>> getFoodItems() async {
    var data = await firestore.collection('foods').get();

    return data;
  }

  @override
  void onInit() {
    super.onInit();
    navC;
    getFoodItems();
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
