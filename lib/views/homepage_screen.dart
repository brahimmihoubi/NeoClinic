import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/widgets/sectioncard_widget.dart';
import '../controllers/homepagecontroller.dart';
import '../widgets/loading_widget.dart';

class HomePageScreen extends StatelessWidget {
  final HomePageController ctrl = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neo Clinic')),
      body: Obx(() {
        if (ctrl.loading.value) return LoadingWidget();
        if (ctrl.error.value.isNotEmpty) return Center(child: Text(ctrl.error.value));
        return ListView(
          children: [
            SectionCard(
              icon: Icons.calendar_today,
              title: 'Appointments',
              count: ctrl.appointments.length,
              onTap: () => ctrl.onSectionTap('appointments'),
            ),
            SectionCard(
              icon: Icons.folder_shared,
              title: 'Medical Records',
              count: ctrl.records.length,
              onTap: () => ctrl.onSectionTap('medical_records'),
            ),
            SectionCard(
              icon: Icons.message,
              title: 'Message Doctor',
              count: ctrl.messages.length,
              onTap: () => ctrl.onSectionTap('message_doctor'),
            ),
            SectionCard(
              icon: Icons.monitor_heart,
              title: 'Health Monitoring',
              count: ctrl.monitoring.length,
              onTap: () => ctrl.onSectionTap('health_monitoring'),
            ),
            SectionCard(
              icon: Icons.alarm,
              title: 'Medication Reminders',
              count: ctrl.reminders.length,
              onTap: () => ctrl.onSectionTap('medication_reminders'),
            ),
          ],
        );
      }),
    );
  }
}
