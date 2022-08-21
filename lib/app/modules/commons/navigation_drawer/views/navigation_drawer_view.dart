// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, prefer_interpolation_to_compose_strings

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
            padding: EdgeInsets.zero,
            children: [
              buildDrawerHeader(),
              buildDrawerItem(
                icon: Icons.home_filled,
                text: "Home",
                onTap: () => navigate(0),
                tileColor: null,
                textIconColor: Get.currentRoute == Routes.HOME
                    ? appThemeData.accentColor
                    : Colors.black,
              ),
              buildDrawerItem(
                icon: Icons.restaurant,
                text: "Daftar Menu Makanan",
                onTap: () => navigate(1),
                tileColor: null,
                textIconColor: Get.currentRoute == Routes.DAFTAR_MENU_MAKANAN
                    ? appThemeData.accentColor
                    : Colors.black,
              ),
              buildDrawerItem(
                  icon: Icons.description,
                  text: "Keterangan Kalori",
                  onTap: () => navigate(2),
                  tileColor: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? appThemeData.accentColor
                      : null,
                  textIconColor: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? appThemeData.backgroundColor
                      : Colors.black),
              buildDrawerItem(
                  icon: Icons.settings,
                  text: "Pengaturan",
                  onTap: () => navigate(3),
                  tileColor: Get.currentRoute == Routes.PENGATURAN
                      ? appThemeData.accentColor
                      : null,
                  textIconColor: Get.currentRoute == Routes.PENGATURAN
                      ? appThemeData.backgroundColor
                      : Colors.black),
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
          colors: [appThemeData.primaryColor, appThemeData.accentColor],
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, " + controller.fullname,
            style: TextStyle(fontSize: 35, color: appThemeData.backgroundColor),
          ),
          Text(
            controller.email,
            style: TextStyle(fontSize: 20, color: appThemeData.backgroundColor),
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
