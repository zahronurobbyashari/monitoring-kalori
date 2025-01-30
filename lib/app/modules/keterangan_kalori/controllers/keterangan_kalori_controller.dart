// ignore_for_file: unnecessary_overrides, unnecessary_brace_in_string_interps, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monitoring_kalori/app/modules/commons/navigation_drawer/controllers/navigation_drawer_controller.dart';

class KeteranganKaloriController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var selectedDate = DateTime.now().obs;
  var totalCalories = 0.0.obs;
  final navC = Get.put(NavigationDrawerController());

  void fetchTotalCalories() async {
    try {
      var dateString =
          "${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}";
      var calorieDoc = await firestore
          .collection('users')
          .doc(auth.currentUser!.email)
          .get();
      if (calorieDoc.exists) {
        var todayCalories =
            calorieDoc.data()?['record'][dateString]['total_calories'];
        print("kalori hari ini tanggal ${dateString} adalah ${todayCalories} ");
        // totalCalories.value = calorieDoc.data()?['total_calories'] ?? 0.0;
        totalCalories.value = todayCalories ?? 0.0;
      } else {
        totalCalories.value = 0.0;
        print("kalori ga nemu");
      }
    } catch (e) {
      totalCalories.value = 0.0;
      print('Error fetching data: $e');
      print('data not found');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTotalCalories();
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
