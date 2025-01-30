// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/modules/login/controllers/login_controller.dart';

import '../../../../data/theme/appTheme.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/navigation_drawer_controller.dart';

class NavigationDrawerView extends GetView<NavigationDrawerController> {
  const NavigationDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(LoginController());
    return Drawer(
      child: Container(
        margin: EdgeInsets.zero,
        child: Container(
          margin: EdgeInsets.zero,
          child: ListView(
            shrinkWrap: true,
            children: [
              buildDrawerHeader(),
              buildDrawerItem(
                icon: Icons.home_filled,
                text: "Home",
                onTap: () => navigate(0),
                tileColor: null,
                textIconColor: Get.currentRoute == Routes.HOME
                    ? appThemeData.colorScheme.secondary
                    : Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Divider(
                  thickness: 1,
                  color: Get.currentRoute == Routes.HOME
                      ? appThemeData.colorScheme.secondary
                      : null,
                ),
              ),
              buildDrawerItem(
                icon: Icons.restaurant,
                text: "Daftar Menu Makanan",
                onTap: () => navigate(1),
                tileColor: null,
                textIconColor: Get.currentRoute == Routes.DAFTAR_MENU_MAKANAN
                    ? appThemeData.colorScheme.secondary
                    : Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Divider(
                  thickness: 1,
                  color: Get.currentRoute == Routes.DAFTAR_MENU_MAKANAN
                      ? appThemeData.colorScheme.secondary
                      : null,
                ),
              ),
              buildDrawerItem(
                  icon: Icons.description,
                  text: "Pantauan Kalori",
                  onTap: () => navigate(2),
                  tileColor: null,
                  textIconColor: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? appThemeData.colorScheme.secondary
                      : Colors.black),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Divider(
                  thickness: 1,
                  color: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? appThemeData.colorScheme.secondary
                      : null,
                ),
              ),
              buildDrawerItem(
                  icon: Icons.settings,
                  text: "Pengaturan",
                  onTap: () => navigate(3),
                  tileColor: null,
                  textIconColor: Get.currentRoute == Routes.PENGATURAN
                      ? appThemeData.colorScheme.secondary
                      : Colors.black),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Divider(
                  thickness: 1,
                  color: Get.currentRoute == Routes.PENGATURAN
                      ? appThemeData.colorScheme.secondary
                      : null,
                ),
              ),
              buildDrawerItem(
                  icon: Icons.logout_outlined,
                  text: "Sign out",
                  onTap: () => authC.signOut(),
                  tileColor: null,
                  textIconColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 1.0],
          colors: [
            appThemeData.primaryColor,
            appThemeData.colorScheme.secondary
          ],
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, " + controller.fullname,
            style: TextStyle(fontSize: 35, color: appThemeData.canvasColor),
          ),
          Text(
            controller.email,
            style: TextStyle(fontSize: 20, color: appThemeData.canvasColor),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.toNamed(Routes.HOME);
    } else if (index == 1) {
      Get.toNamed(Routes.DAFTAR_MENU_MAKANAN);
    } else if (index == 2) {
      Get.toNamed(Routes.KETERANGAN_KALORI);
    } else if (index == 3) {
      Get.toNamed(Routes.PENGATURAN);
    }
  }
}
