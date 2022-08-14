import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/data/theme/colorTheme.dart';

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
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.grey,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Container(
                  height: height * 0.3,
                  child: HeaderWidget(),
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
                          TextField(
                              controller: controller.fullnamec,
                              decoration: FormHelper().textInputDecoration(
                                  'Full name', 'Enter your full name')),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                              controller: controller.emailc,
                              // validator: (value) => EmailValidator.validate(
                              //         controller.emailc.text)
                              //     ? null
                              //     : "Please enter a valid email",
                              decoration: FormHelper().textInputDecoration(
                                  'Email', 'Enter your email')),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextField(
                              controller: controller.passc,
                              obscureText: true,
                              decoration: FormHelper().textInputDecoration(
                                  'Password', 'Enter your password')),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          TextField(
                              controller: controller.confirmpassc,
                              obscureText: true,
                              decoration: FormHelper().textInputDecoration(
                                  'Confirm your password',
                                  'Confirm your password')),
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
                                controller.postRegister(
                                    controller.fullnamec.text,
                                    controller.emailc.text,
                                    controller.passc.text,
                                    controller.confirmpassc.text);
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
                                style: TextStyle(fontSize: 18),
                                children: [
                                  TextSpan(text: "Already have a account?"),
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
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              height: height * 0.13,
              width: width * 0.4,
              decoration: BoxDecoration(
                color: appThemeData.primaryColor,
              ),
            ),
          ),
          ClipPath(
            clipper: TopClipper(),
            child: Container(
              alignment: Alignment.topRight,
              height: height * 0.13,
              width: width * 0.4,
              decoration: BoxDecoration(
                color: appThemeData.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.2);

    // path.quadraticBezierTo(0, size.height * 0.2, , size.height);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.4);

    // path.quadraticBezierTo(0, size.height * 0.2, , size.height);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
