import '../models/appointment_model.dart';

class AppointmentService {
  Future<List<AppointmentModel>> fetchAppointments() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      AppointmentModel(
        id: '1',
        doctorName: 'Dr. Smith',
        dateTime: DateTime.now().add(Duration(days: 2)),
        notes: 'Annual checkup',
        isUpcoming: true,
      ),
      AppointmentModel(
        id: '2',
        doctorName: 'Dr. Lee',
        dateTime: DateTime.now().subtract(Duration(days: 3)),
        notes: 'Follow-up visit',
        isUpcoming: false,
      ),
    ];
  }

  Future<void> bookAppointment(AppointmentModel appointment) async {
    await Future.delayed(Duration(seconds: 1));
    // Simulate booking logic
  }
}