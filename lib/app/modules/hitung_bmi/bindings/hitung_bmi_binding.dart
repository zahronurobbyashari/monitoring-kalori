import 'package:get/get.dart';

import '../controllers/hitung_bmi_controller.dart';

class HitungBmiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HitungBmiController>(
      () => HitungBmiController(),
    );
  }
}
