import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final count = 0.obs;
  var gram = 14.toString();

  Future<QuerySnapshot<Object?>> getFoodItems() async {
    var data = await firestore.collection('foods').get();

    return data;
  }

  @override
  void onInit() {
    super.onInit();
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

  void increment() => count.value++;
}
