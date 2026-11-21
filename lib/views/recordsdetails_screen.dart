import 'package:flutter/material.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';

class RecordDetailScreen extends StatelessWidget {
  final MedicalRecord? record;

  const RecordDetailScreen({required this.record});

  @override
  Widget build(BuildContext context) {
    if (record == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('No appointment data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(record!.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${record?.type}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Date: ${record?.date.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Content:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(record!.content),
          ],
        ),
      ),
    );
  }
}