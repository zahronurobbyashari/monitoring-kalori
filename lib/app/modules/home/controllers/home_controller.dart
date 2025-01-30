// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/modules/commons/navigation_drawer/controllers/navigation_drawer_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('send/weight');
  FirebaseAuth auth = FirebaseAuth.instance;

  final navC = Get.put(NavigationDrawerController());

  var weight = 0.0.obs;
  var caloriesPerGram = 0.0.obs;
  var selectedFoods = <Map<String, dynamic>>[].obs;
  var foodsAndWeights = <Map<String, dynamic>>[].obs;
  var totalCalories = 0.0.obs;
  var dailyCaloriesNeeds = 0.0.obs;

  Future<QuerySnapshot<Object?>> getFoodItems() async {
    return FirebaseFirestore.instance.collection('foods').get();
  }

  void fetchDataAndCalculateCalories(String email) async {
    try {
      // Contoh mengambil data dari Firestore
      await firestore
          .collection('users')
          // .where('email', isEqualTo: email)
          .doc(auth.currentUser!.email)
          // .limit(1)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        dailyCaloriesNeeds.value =
            documentSnapshot.get('dailyCaloriesNeeds') ?? 0.0.obs;
        totalCalories.value = documentSnapshot.get('total_calories') ?? 0.0.obs;
        print(
            'Kebutuhan Kalori Harian: ${dailyCaloriesNeeds.value.toString()}');
        print("initial total kalori ${totalCalories.value.toString()}");
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void calculateTotalCalories() {
    print("before ${totalCalories.value}");
    for (var food in selectedFoods) {
      totalCalories.value += weight.value * food['multiplier'];
    }
    print('After Total Calories: ${totalCalories.value}');
  }

  void fetchWeight() {
    databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        weight.value = double.parse(event.snapshot.value.toString());
        print('Weight: ${weight.value}');
        calculateTotalCalories(); // Recalculate whenever weight changes
      }
    });
  }

  void addFood(Map<String, dynamic> food, double foodWeight) {
    foodsAndWeights.add({
      'food_name': food['food_name'],
      'multiplier': food['multiplier'],
      'weight': foodWeight,
    });
    calculateTotalCalories();
  }

  void saveTotalCalories() async {
    print('do save total calories : ');
    try {
      var dateString =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      await firestore.collection('users').doc(auth.currentUser!.email).set({
        'record': {
          dateString: {
            'total_calories': totalCalories.value,
          },
        },
        'total_calories': totalCalories.value,
        'foods': foodsAndWeights.map((food) {
          // iki total kalori e sek yo, food e mben
          return {
            'food_name': food['food_name'],
            'multiplier': food['multiplier'],
            'weight': food['weight'],
          };
        }).toList(),
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      Get.snackbar('Success', 'Total calories saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save total calories');
    }
  }

  void resetTotalCalories() {
    totalCalories.value = 0.0;
    selectedFoods.clear(); // Optionally clear the selected foods list
    foodsAndWeights.clear(); // Optionally clear the foods and weights list
  }

  String realTimeValue = '0';

  @override
  void onInit() {
    // DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    // databaseReference.child('send/weight').onValue.listen((event) {
    // if (event.snapshot.value != null) {
    // print('Data: ${event.snapshot.value.toString()}');
    // Handle the updated data as needed
    // }
    // });

    super.onInit();
    String userEmail = navC.email;
    // navC;
    getFoodItems();
    fetchWeight();
    fetchDataAndCalculateCalories(userEmail);
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
