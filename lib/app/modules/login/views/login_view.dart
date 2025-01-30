// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appThemeData.canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              height: height * 0.3,
              child: Image.asset(
                'assets/images/test.png',
                height: height * 0.17,
              ),
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
                        "Login",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Please sign in to continue.",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          emailField(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          passwordField(),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: const Text('Forgot your password?'),
                          ),
                          Container(
                            decoration:
                                FormHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: FormHelper().buttonStyle(),
                              onPressed: () {
                                controller.checkLogin();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Text(
                                  'Sign in'.toUpperCase(),
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
                                      text: "Don't have an account?"),
                                  TextSpan(
                                      style: TextStyle(
                                          color: appThemeData.primaryColor,
                                          fontWeight: FontWeight.bold),
                                      text: " Create",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.getRegister();
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

  Widget emailField() {
    return TextFormField(
      controller: controller.emailc,
      decoration: FormHelper().textInputDecoration(
        'Email',
        'Enter your email',
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
        'Password',
        'Enter your password',
      ),
      onSaved: (value) => controller.password = value!,
      validator: (value) => controller.ValidatePassword(value!),
    );
  }
}
