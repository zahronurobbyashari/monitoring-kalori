// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
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
              colors: [appThemeData.primaryColor, appThemeData.accentColor],
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
            height: height * 0.4,
            width: width * 0.7,
            child: KkalIndicator(),
          ),
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
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            'Submit'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget gramField() {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        fillColor: appThemeData.backgroundColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'food weight',
      ),
      readOnly: true,
      initialValue: controller.gram,
      maxLength: 6,
    );
  }

  Widget foodsField() {
    return FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.getFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot);
            var allFoods = snapshot.data!.docs;
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
                  'Choose food',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: allFoods
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id,
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
                    return 'Please select food.';
                  }
                },
                onChanged: (value) {
                  print(value);
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {});
          }
          return CircularProgressIndicator();
        });
  }

  Widget KkalIndicator() {
    return CircularPercentIndicator(
      radius: 150,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: appThemeData.accentColor,
      percent: 0.7,
      center: Text(
        "880 kkal",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      footer: Text(
        "Kalori ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
    );
  }
}
