// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
import '../../commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/kalori_dikonsumsi_controller.dart';

class KaloriDikonsumsiView extends GetView<KaloriDikonsumsiController> {
  const KaloriDikonsumsiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerView(),
      appBar: AppBar(
        title: Text('Kalori Dikonsumsi'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [
                appThemeData.primaryColor,
                appThemeData.colorScheme.secondary
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'KaloriDikonsumsiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
