// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/theme/appTheme.dart';
import '../../commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../controllers/daftar_menu_makanan_controller.dart';

class DaftarMenuMakananView extends GetView<DaftarMenuMakananController> {
  const DaftarMenuMakananView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerView(),
      appBar: AppBar(
        title: Text('Daftar Menu Makanan'),
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
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getFoods(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var listFoods = snapshot.data!.docs;
          return ListView.builder(
            itemCount: listFoods.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  "${(listFoods[index].data() as Map<String, dynamic>)["food_name"]}"),
              subtitle: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "kalori : " +
                    (double.parse(listFoods[index].get('multiplier')) * 100)
                        .toInt()
                        .toString() +
                    " kkal per 100 gram",
              ),
            ),
          );
        }),
      ),
    );
  }
}
