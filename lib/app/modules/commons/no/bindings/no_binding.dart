import 'package:get/get.dart';

import '../controllers/no_controller.dart';

class NoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoController>(
      () => NoController(),
    );
  }
}
