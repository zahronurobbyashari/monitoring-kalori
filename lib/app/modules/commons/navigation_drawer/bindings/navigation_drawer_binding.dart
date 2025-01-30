import 'package:get/get.dart';

import '../controllers/navigation_drawer_controller.dart';

class NavigationDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationDrawerController(), permanent: true);
  }
}
