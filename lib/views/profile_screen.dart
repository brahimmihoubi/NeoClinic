import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/profilecontroller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF3D5AFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(height: 16),
            Obx(() => Text('Name: ${controller.userName}', style: TextStyle(fontSize: 18))),
            Obx(() => Text('Email: ${controller.userEmail}', style: TextStyle(fontSize: 16))),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: controller.logout,
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
