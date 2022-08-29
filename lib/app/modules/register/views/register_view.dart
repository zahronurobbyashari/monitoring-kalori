// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/data/theme/appTheme.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appThemeData.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 40),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.grey,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  height: height * 0.3,
                  child: Image.asset(
                    'assets/images/test.png',
                    height: height * 0.17,
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Create Account",
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
                      autovalidateMode: AutovalidateMode.always,
                      key: controller.formKey,
                      child: Column(
                        children: [
                          fullNameField(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          emailField(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          passwordField(),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          confirmPasswordField(),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration:
                                FormHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: FormHelper().buttonStyle(),
                              onPressed: () {
                                controller.checkRegister();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Text(
                                  'Register'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 18),
                                children: [
                                  const TextSpan(
                                      text: "Already have a account?"),
                                  TextSpan(
                                      style: TextStyle(
                                          color: appThemeData.primaryColor,
                                          fontWeight: FontWeight.bold),
                                      text: " Sign In",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.getLogin();
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fullNameField() {
    return TextFormField(
      controller: controller.fullnamec,
      decoration:
          FormHelper().textInputDecoration('Full name', 'Enter your full name'),
      onSaved: (value) => controller.fullname = value!,
      validator: (value) => controller.ValidateFullName(value!),
      keyboardType: TextInputType.name,
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: controller.emailc,
      decoration: FormHelper().textInputDecoration(
        'email ',
        'enter your Email',
      ),
      onSaved: (value) => controller.email = value!,
      validator: (value) => controller.ValidateEmail(value!),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: controller.passwordc,
      obscureText: true,
      decoration: FormHelper().textInputDecoration(
        'password',
        'enter your password',
      ),
      onSaved: (value) => controller.password = value!,
      validator: (value) => controller.ValidatePassword(value!),
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: controller.confirmpasswordc,
      obscureText: true,
      decoration: FormHelper().textInputDecoration(
        'confirm your password',
        'enter your password once again',
      ),
      onSaved: (value) => controller.confirmPassword = value!,
      validator: (value) => controller.ValidateConfirmPassword(value!),
    );
  }
}
