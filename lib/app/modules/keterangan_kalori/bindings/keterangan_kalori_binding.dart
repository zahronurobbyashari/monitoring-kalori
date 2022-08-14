import 'package:get/get.dart';

import '../controllers/keterangan_kalori_controller.dart';

class KeteranganKaloriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeteranganKaloriController>(
      () => KeteranganKaloriController(),
    );
  }
}
