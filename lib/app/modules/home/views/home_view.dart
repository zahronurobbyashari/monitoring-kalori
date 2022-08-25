// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:monitoring_kalori/app/data/theme/appTheme.dart';
import 'package:monitoring_kalori/app/modules/commons/navigation_drawer/views/navigation_drawer_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerView(),
      appBar: AppBar(
        title: Text('Dashboard'),
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
        child: CircularPercentIndicator(
          radius: 150,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: appThemeData.accentColor,
          percent: 0.7,
          center: Text(
            "70.0%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
