// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/data/theme/appTheme.dart';
import 'package:select_form_field/select_form_field.dart';

import '../controllers/hitung_bmi_controller.dart';

class HitungBmiView extends GetView<HitungBmiController> {
  const HitungBmiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Map<String, dynamic>> _items = [
      {
        'value': '1',
        'label': 'Man',
        'icon': Icon(Icons.man),
      },
      {
        'value': '2',
        'label': 'Woman',
        'icon': Icon(Icons.woman),
      },
    ];

    return Scaffold(
        backgroundColor: appThemeData.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: Container(
                child: Column(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Count BMI first to continue",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        decoration: FormHelper().textInputDecoration(
                          'height (cm)',
                          'enter your height',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        decoration: FormHelper().textInputDecoration(
                          'weight(kg)',
                          'enter your weight',
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('gender'),
                            ),
                            Row(
                              children: [
                                Obx(() => Radio(
                                      value: "Male",
                                      groupValue:
                                          controller.selectedGender.value,
                                      onChanged: (value) {
                                        controller.onChangeGender(value);
                                      },
                                      activeColor: appThemeData.accentColor,
                                      fillColor: MaterialStateProperty.all(
                                          appThemeData.primaryColor),
                                    )),
                                Text("Male"),
                              ],
                            ),
                            Row(
                              children: [
                                Obx(() => Radio(
                                      value: "Female",
                                      groupValue:
                                          controller.selectedGender.value,
                                      onChanged: (value) {
                                        controller.onChangeGender(value);
                                      },
                                      activeColor: appThemeData.accentColor,
                                      fillColor: MaterialStateProperty.all(
                                          appThemeData.primaryColor),
                                    )),
                                Text("Female"),
                              ],
                            )
                          ],
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
                              'Next'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                ]),
              ))
            ],
          ),
        ));
  }
}
