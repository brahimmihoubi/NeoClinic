import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/medicationcontroller.dart';

class MedicationScreen extends StatelessWidget {
  final controller = Get.put(MedicationController());
  final nameController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        backgroundColor: Color(0xFF3D5AFE),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Medication Name'),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.addReminder(nameController.text, timeController.text);
                    nameController.clear();
                    timeController.clear();
                  },
                  child: Text('Add Reminder'),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = controller.reminders[index];
                    return ListTile(
                      title: Text(reminder.name),
                      subtitle: Text('Time: ${reminder.time}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeReminder(index),
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}