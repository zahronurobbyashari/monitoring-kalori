// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
import '../../commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/keterangan_kalori_controller.dart';

class KeteranganKaloriView extends GetView<KeteranganKaloriController> {
  const KeteranganKaloriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerView(),
      appBar: AppBar(
        title: Text('Keterangan Kalori'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [appThemeData.primaryColor, appThemeData.accentColor],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'KeteranganKaloriView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
