// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
import '../../commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: NavigationDrawerView(),
        appBar: AppBar(
          title: Text('Pengaturan'),
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
          child: Column(
            children: [
              SafeArea(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Account Setting",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Form(
                            child: Column(
                              children: [
                                emailField(),
                                passwordField(),
                                reTypePasswordField(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Container(
                            decoration:
                                FormHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: FormHelper().buttonStyle(),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Text(
                                  'Save'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Change weight or height",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Form(
                            child: Column(
                              children: [
                                heightField(),
                                weightField(),
                                ageField(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Container(
                            decoration:
                                FormHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: FormHelper().buttonStyle(),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Text(
                                  'Save'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ));
  }

  Widget emailField() {
    return TextFormField(
      decoration: FormHelper().textInputDecoration(
        'Email',
        'Enter your email',
      ),
      onSaved: (value) {},
      validator: (value) {},
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: FormHelper().textInputDecoration(
        'Password',
        'Enter your password',
      ),
      onSaved: (value) {},
      validator: (value) {},
    );
  }

  Widget reTypePasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: FormHelper().textInputDecoration(
        'Password',
        'Enter your password',
      ),
      onSaved: (value) {},
      validator: (value) {},
    );
  }

  Widget heightField() {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: FormHelper().textInputDecoration(
        'height (cm)',
        'enter your height',
      ),
      onSaved: (value) {},
      keyboardType: TextInputType.number,
      validator: (value) {},
    );
  }

  Widget weightField() {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: FormHelper().textInputDecoration(
        'weight(kg)',
        'enter your weight',
      ),
      onSaved: (value) {},
      keyboardType: TextInputType.number,
      validator: (value) {},
    );
  }

  Widget ageField() {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(2),
      ],
      decoration: FormHelper().textInputDecoration(
        'Umur',
        'enter your umur',
      ),
      onSaved: (value) {},
      keyboardType: TextInputType.number,
      validator: (value) {},
    );
  }
}
