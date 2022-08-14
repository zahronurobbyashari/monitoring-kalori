import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/colorTheme.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appThemeData.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: controller.headerHeight,
              child: HeaderWidget(),
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
                          TextField(
                              controller: controller.emailc,
                              decoration: FormHelper().textInputDecoration(
                                  'Username', 'Enter your username')),
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
                                controller.login(controller.emailc.text,
                                    controller.passc.text);
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
                                style: TextStyle(fontSize: 18),
                                children: [
                                  TextSpan(text: "Don't have an account?"),
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
