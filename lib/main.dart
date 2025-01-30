import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'monitoring-kalori',
      options: const FirebaseOptions(
        apiKey: "AIzaSyBi36NlGR3pDXo8e5wht1aPaTwfJTo9o4U",
        appId: "1:186591609757:android:536945f313e70555892574",
        messagingSenderId: "186591609757",
        projectId: "monitoring-kalori",
        databaseURL:
            "https://monitoring-kalori-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
