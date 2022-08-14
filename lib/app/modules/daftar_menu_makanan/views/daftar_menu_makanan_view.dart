import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/daftar_menu_makanan_controller.dart';

class DaftarMenuMakananView extends GetView<DaftarMenuMakananController> {
  const DaftarMenuMakananView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DaftarMenuMakananView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DaftarMenuMakananView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
