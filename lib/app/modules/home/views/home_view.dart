// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, avoid_print, non_constant_identifier_names, body_might_complete_normally_nullable, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/data/theme/appTheme.dart';
import 'package:monitoring_kalori/app/modules/commons/navigation_drawer/views/navigation_drawer_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../controllers/home_controller.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    controller.fetchWeight();

    return Scaffold(
      drawer: NavigationDrawerView(),
      appBar: AppBar(
        title: Text('Dashboard'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [
                appThemeData.primaryColor,
                appThemeData.colorScheme.secondary
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.07,
          ),
          Container(
            height: height * 0.45,
            width: width * 0.7,
            child: KkalIndicator(),
          ),
          // SizedBox(height: 20),
          // Obx(() {
          //   if (controller.dailyCaloriesNeeds.value == 0.0) {
          //     return CircularProgressIndicator();
          //   } else {
          //     return Text(
          //       'Daily Calories Needs: ${controller.dailyCaloriesNeeds.value.toStringAsFixed(2)} kcal',
          //       style: TextStyle(fontSize: 18),
          //     );
          //   }
          // }),
          // SizedBox(height: 20),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 21),
                                    width: width * 0.23,
                                    child: gramField()),
                                Container(
                                    width: width * 0.43, child: foodsField()),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: FormHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: FormHelper().buttonStyle(),
                        onPressed: () {
                          // controller.calculateTotalCalories();
                          print(
                              "sebelum calculate : ${controller.totalCalories.value}");
                          controller.totalCalories.value +=
                              controller.weight.value *
                                  controller.caloriesPerGram.value;
                          print(
                              "on press calculate: ${controller.totalCalories.value}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            'Calculate'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: FormHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: FormHelper().buttonStyle(),
                        onPressed: () {
                          controller.saveTotalCalories();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            'Submit'.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      // return Column(
                      //   children: controller.foodsAndWeights.map((food) {
                      //     return ListTile(
                      //       title: Text(
                      //           '${food['food_name']} (${food['weight']}grams)'),
                      //       subtitle: Text(
                      //           '${food['weight'] * double.parse(food['multiplier'].toString())} kcal'),
                      //     );
                      //   }).toList(),
                      // );
                      return Text(
                        'Total Calories: ${controller.totalCalories.value.toStringAsFixed(2)} kcal',
                        style: TextStyle(fontSize: 20),
                      );
                    }),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.resetTotalCalories,
                      child: Text('Reset Total Calories'),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget gramField() {
    // return Obx(() {
    //   if (controller.weight.value == 0.0) {
    //     return Center(child: CircularProgressIndicator());
    //   } else {
    //     return Text('Berat Makanan: ${controller.weight.value} gram');
    //   }
    // });

    final DatabaseReference _databaseReference =
        FirebaseDatabase.instance.ref().child('send/weight');

    return StreamBuilder(
        stream: _databaseReference.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            var weight = snapshot.data!.snapshot.value;
            controller.weight.value = double.parse(weight.toString());
            print("controller :" + controller.weight.value.toString());
            return Text('Berat Makanan: ' + weight.toString() + ' gram');
          }
        });
  }

  Widget foodsField() {
    return FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.getFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            var allFoods = snapshot.data!.docs;
            //   return Column(
            //     children: allFoods.map((item) {
            //       var caloriesPerGram = item.get('multiplier');
            //       var foodName = item.get('food_name');
            //       return CheckboxListTile(
            //         title: Text(foodName),
            //         value: controller.selectedFoods
            //             .any((food) => food['food_name'] == foodName),
            //         onChanged: (bool? value) {
            //           if (value == true) {
            //             controller.selectedFoods.add({
            //               'food_name': foodName,
            //               'multiplier': caloriesPerGram,
            //             });
            //           } else {
            //             controller.selectedFoods
            //                 .removeWhere((food) => food['food_name'] == foodName);
            //           }
            //           controller.calculateTotalCalories();
            //         },
            //       );
            //     }).toList(),
            //   );
            // }
            return DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Pilih Makanan',
                  style: TextStyle(fontSize: 14),
                ),
                iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                ),
                buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 50,
                    padding: const EdgeInsets.only(left: 20, right: 10)),
                items: allFoods
                    .map((item) => DropdownMenuItem<String>(
                          value: item.get('multiplier'),
                          child: Text(
                            item.get('food_name'),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih Makanan.';
                  }
                },
                onChanged: (value) {
                  print(value);
                  controller.caloriesPerGram.value =
                      double.parse(value.toString());
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {});
          }
          return CircularProgressIndicator();
        });
  }

  Widget KkalIndicator() {
    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: controller.navC.getuser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var user = snapshot.data!.data();
        var status_bmi = (user as Map<String, dynamic>)["bmi label"];
        var weight = (user as Map<String, dynamic>)["weight"];
        var berat_ideal = (user as Map<String, dynamic>)["berat badan ideal"];
        var dailyCaloriesNeeds =
            (user as Map<String, dynamic>)["kebutuhan kalori harian"];

        return CircularPercentIndicator(
          radius: 150, //     animation: true,
          circularStrokeCap: CircularStrokeCap.round,

          progressColor: status_bmi == 'Terlalu Sangat Kurus' ||
                  status_bmi == 'Sangat Kurus' ||
                  status_bmi == 'Obesitas' ||
                  status_bmi == 'Sangat Gemuk' ||
                  status_bmi == 'Cukup Gemuk'
              ? Colors.red
              : status_bmi == 'Kurus' || status_bmi == 'Gemuk'
                  ? appThemeData.colorScheme.secondary
                  : Colors.green,

          percent: weight / berat_ideal > 1 ? 1 : weight / berat_ideal,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Berat anda saat ini " + weight.toString() + " kg",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(height: 10),
              Obx(() => Center(
                    child: Text(
                      'Kebutuhan Kalori Harian: ${controller.dailyCaloriesNeeds.value.toString()} kcal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  )),
            ],
          ),
          footer: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              status_bmi == 'Normal'
                  ? 'Berat badan Anda ideal, pertahankan pola makan dan olahraga Anda.'
                  : "Saat ini anda " +
                      status_bmi +
                      ", Anda harus mencapai berat badan ideal anda yaitu : " +
                      berat_ideal.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
        );
      },
    );
  }
}
