// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/modules/login/controllers/login_controller.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/navigation_drawer_controller.dart';

class NavigationDrawerView extends GetView<NavigationDrawerController> {
  const NavigationDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(LoginController());
    return Drawer(
      child: Container(
        child: Container(
          child: ListView(
            children: [
              buildDrawerHeader(),
              Divider(
                color: Colors.grey,
              ),
              buildDrawerItem(
                icon: Icons.photo,
                text: "Home",
                onTap: () => navigate(0),
                tileColor: Get.currentRoute == Routes.HOME ? Colors.blue : null,
                textIconColor: Get.currentRoute == Routes.HOME
                    ? Colors.white
                    : Colors.black,
              ),
              buildDrawerItem(
                icon: Icons.video_call,
                text: "Daftar Menu Makanan",
                onTap: () => navigate(1),
                tileColor: Get.currentRoute == Routes.DAFTAR_MENU_MAKANAN
                    ? Colors.blue
                    : null,
                textIconColor: Get.currentRoute == Routes.DAFTAR_MENU_MAKANAN
                    ? Colors.white
                    : Colors.black,
              ),
              buildDrawerItem(
                  icon: Icons.chat,
                  text: "Keterangan Kalori",
                  onTap: () => navigate(2),
                  tileColor: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? Colors.blue
                      : null,
                  textIconColor: Get.currentRoute == Routes.KETERANGAN_KALORI
                      ? Colors.white
                      : Colors.black),
              buildDrawerItem(
                  icon: Icons.chat,
                  text: "Pengaturan",
                  onTap: () => navigate(3),
                  tileColor: Get.currentRoute == Routes.PENGATURAN
                      ? Colors.blue
                      : null,
                  textIconColor: Get.currentRoute == Routes.PENGATURAN
                      ? Colors.white
                      : Colors.black),
              buildDrawerItem(
                  icon: Icons.chat,
                  text: "Sign out",
                  onTap: () => authC.signOut(),
                  tileColor: Colors.white,
                  textIconColor: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDrawerHeader() {
  return UserAccountsDrawerHeader(
    accountName: Text("Ripples Code"),
    accountEmail: Text("ripplescode@gmail.com"),

    currentAccountPictureSize: Size.square(72),
    // ignore: prefer_const_literals_to_create_immutables
    otherAccountsPictures: [
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Text("RC"),
      )
    ],
    otherAccountsPicturesSize: Size.square(50),
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
