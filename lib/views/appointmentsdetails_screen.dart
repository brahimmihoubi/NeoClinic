import 'package:flutter/material.dart';
import 'package:neoclinic/models/appointment_model.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final AppointmentModel? appointment;
  
  const AppointmentDetailScreen({this.appointment, super.key});

  @override
  Widget build(BuildContext context) {
    if (appointment == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('No appointment data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Appointment Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctor: Dr. ${appointment!.doctorName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date & Time: ${appointment!.dateTime}'),
            SizedBox(height: 10),
            Text('Notes: ${appointment!.notes}'),
          ],
        ),
      ),
    );
  }
}