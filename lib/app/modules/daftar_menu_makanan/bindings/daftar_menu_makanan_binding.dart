import 'package:get/get.dart';

import '../controllers/daftar_menu_makanan_controller.dart';

class DaftarMenuMakananBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DaftarMenuMakananController());
  }
}
