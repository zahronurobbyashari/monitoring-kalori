import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HitungBmiController extends GetxController {
  //TODO: Implement HitungBmiController

  final count = 0.obs;
  var selectedGender = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onChangeGender(var gender) {
    selectedGender.value = gender;
    print(selectedGender.value);
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

  void increment() => count.value++;
}
