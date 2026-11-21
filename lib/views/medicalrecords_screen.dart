import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/medicalrecordscontroller.dart';
import 'package:neoclinic/views/recordsdetails_screen.dart';
import 'package:neoclinic/views/uploadrecords_screen.dart';

class MedicalRecordsScreen extends StatelessWidget {
  final controller = Get.put(MedicalRecordsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchRecords();
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(() => UploadRecordScreen()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search records...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: controller.setSearchQuery,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return Center(child: CircularProgressIndicator());
              if (controller.filteredRecords.isEmpty) return Center(child: Text('No records found.'));
              return ListView.builder(
                itemCount: controller.filteredRecords.length,
                itemBuilder: (_, i) {
                  final record = controller.filteredRecords[i];
                  return ListTile(
                    title: Text(record.title),
                    subtitle: Text('${record.type} • ${record.date.toLocal().toString().split(' ')[0]}'),
                    onTap: () => Get.to(() => RecordDetailScreen(record: record)),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}