import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknikal_test/components/berita/main_kategori_view.dart';
import 'package:teknikal_test/widget/text_label.dart';

import 'utils/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'TEKNIKAL TEST',
        theme: ThemeData(
          fontFamily: 'InterRegular',
        ),
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadingNextRoute();
    super.initState();
  }

  void loadingNextRoute() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAll(MainKategori());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utility.baseColor2,
        body: Center(
          child: TextLabel(text: "Teknikal Test", weigh: FontWeight.bold),
        ));
  }
}
