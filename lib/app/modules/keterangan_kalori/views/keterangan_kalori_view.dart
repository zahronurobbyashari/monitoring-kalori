// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/theme/appTheme.dart';
import '../../commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/keterangan_kalori_controller.dart';

class KeteranganKaloriView extends GetView<KeteranganKaloriController> {
  const KeteranganKaloriView({Key? key}) : super(key: key);
  // final KeteranganKaloriController controller = Get.put(KeteranganKaloriController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerView(),
        appBar: AppBar(
          title: Text('Pantauan Kalori'),
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
        body: Column(
          children: [
            Obx(() {
              return TableCalendar(
                focusedDay: controller.selectedDate.value,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDate.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectedDate.value = selectedDay;
                  controller.fetchTotalCalories();
                },
              );
            }),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Calories: ${controller.totalCalories.value.toStringAsFixed(2)} kcal',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }),
          ],
        ));
  }
}
