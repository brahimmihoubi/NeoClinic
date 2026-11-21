import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/appointment_controller.dart';
import '../../models/appointment_model.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final doctorController = TextEditingController();
  final notesController = TextEditingController();
  final controller = Get.find<AppointmentController>();
  final date = Rxn<DateTime>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: doctorController, decoration: InputDecoration(labelText: 'Doctor Name')),
            TextField(controller: notesController, decoration: InputDecoration(labelText: 'Notes')),
            SizedBox(height: 10),
            Obx(() => Text(date.value == null ? 'No date selected' : date.value.toString())),
            ElevatedButton(
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (selected != null) date.value = selected;
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (doctorController.text.isNotEmpty && date.value != null) {
                  final appointment = AppointmentModel(
                    id: DateTime.now().toIso8601String(),
                    doctorName: doctorController.text,
                    dateTime: date.value!,
                    notes: notesController.text,
                    isUpcoming: true,
                  );
                  controller.bookAppointment(appointment);
                  Get.back();
                }
              },
              child: Text('Book Appointment'),
            )
          ],
        ),
      ),
    );
  }
}