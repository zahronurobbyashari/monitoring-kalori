import 'package:get/get.dart';

import '../controllers/kalori_dikonsumsi_controller.dart';

class KaloriDikonsumsiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KaloriDikonsumsiController>(
      () => KaloriDikonsumsiController(),
    );
  }
}
