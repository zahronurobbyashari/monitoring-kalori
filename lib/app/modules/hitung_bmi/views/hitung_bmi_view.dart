import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hitung_bmi_controller.dart';

class HitungBmiView extends GetView<HitungBmiController> {
  const HitungBmiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HitungBmiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HitungBmiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
