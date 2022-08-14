import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("on init");
  }

  @override
  void onReady() {
    super.onReady();
    print("on ready");
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
