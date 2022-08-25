import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/food.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final count = 0.obs;
  var gram = 14.toString();

  List<Object> foodItems = ['nasi', 'nasi kotak', 'nasi uduk'];

  Future<QuerySnapshot<Object?>> getFoodItems() async {
    CollectionReference foods = firestore.collection('foods');

    return foods.get();
  }

  Future getFoodItemss() async {
    var data = await firestore.collection('foods').get();
    foodItems = List.from(data.docs.map((doc) => Food.fromSnapshot(doc)));
    print(data);
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
