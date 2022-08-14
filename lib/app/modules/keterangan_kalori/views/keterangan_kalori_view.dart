import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keterangan_kalori_controller.dart';

class KeteranganKaloriView extends GetView<KeteranganKaloriController> {
  const KeteranganKaloriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeteranganKaloriView'),
        centerTitle: true,
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
