import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring_kalori/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final fullnamec = TextEditingController();
  final usernamec = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  final confirmpassc = TextEditingController();
  double headerHeight = 250;
  Key formKey = GlobalKey<FormState>();

  void getLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> postRegister(String fullname, String email, String password,
      String confirmPassword) async {
    if (fullname.isNotEmpty) {
      if (email.isNotEmpty) {
        if (email.isEmail) {
          if (password.isNotEmpty) {
            if (password.length >= 8) {
              if (password == confirmPassword) {
                try {
                  await auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Get.offAllNamed(Routes.HITUNG_BMI);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              } else {
                print("password confirm gak podo");
              }
            } else {
              print('password kurang dowo');
            }
          } else {
            print('isi password le');
          }
        } else {
          print("email tidak valid");
        }
      } else {
        print("isi email le");
      }
    } else {
      print("full name le");
    }
  }

  @override
  void onInit() {
    super.onInit();
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
