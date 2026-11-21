import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/emergencycontroller.dart';

class EmergencyScreen extends StatelessWidget {
  final controller = Get.put(EmergencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency'),
        backgroundColor: Color(0xFF3D5AFE),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: controller.callEmergency,
          icon: Icon(Icons.call, size: 32),
          label: Text('Call Emergency', style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
      ),
    );
  }
}