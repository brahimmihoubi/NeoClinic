import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/views/appointmentsdetails_screen.dart';
import '../../controllers/appointment_controller.dart';
import '../../widgets/appointment_card.dart';

class AppointmentsScreen extends StatelessWidget {
  final controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointments')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Upcoming Appointments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...controller.upcomingAppointments.map((appointment) =>
                AppointmentCard(
                  appointment: appointment,
                  onTap: () => Get.to(() => AppointmentDetailScreen(appointment: appointment)),
                )).toList(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Past Appointments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...controller.pastAppointments.map((appointment) =>
                AppointmentCard(
                  appointment: appointment,
                  onTap: () => Get.to(() => AppointmentDetailScreen(appointment: appointment)),
                )).toList(),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/book-appointment'),
        child: Icon(Icons.add),
      ),
    );
  }
}