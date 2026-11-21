import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splashcontroller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/neoclinic_logo.png', width: 120),
      ),
    );
  }
}
