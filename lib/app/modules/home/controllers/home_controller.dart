import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/food.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final count = 0.obs;
  var gram = 14.toString();

  List<Object> foodItems = [];

  Future<QuerySnapshot<Object?>> getFoodItemss() async {
    CollectionReference foods = firestore.collection('foods');

    return foods.get();
  }

  Future<QuerySnapshot<Object?>> getFoodItems() async {
    var data = await firestore.collection('foods').get();
    foodItems = List.from(data.docs.map((doc) => Food.fromSnapshot(doc)));

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
