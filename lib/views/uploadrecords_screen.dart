import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/medicalrecordscontroller.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';

class UploadRecordScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _contentController = TextEditingController();
  final controller = Get.find<MedicalRecordsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _typeController, decoration: InputDecoration(labelText: 'Record Type')),
            TextField(controller: _contentController, decoration: InputDecoration(labelText: 'Content')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final record = MedicalRecord(
                  title: _titleController.text,
                  type: _typeController.text,
                  content: _contentController.text,
                  date: DateTime.now(),
                );
                controller.addRecord(record);
                Get.back();
              },
              child: Text('Upload'),
            )
          ],
        ),
      ),
    );
  }
}
