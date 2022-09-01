// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/no_controller.dart';

class NoView extends GetView<NoController> {
  const NoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
