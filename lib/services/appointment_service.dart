import 'package:neoclinic/models/appointment_model.dart';
import 'package:neoclinic/services/api_service.dart';

class AppointmentService {
  final ApiService _api = ApiService();

  Future<List<AppointmentModel>> fetchAppointments() async {
    return await _api.fetchAppointments();
  }

  Future<bool> bookAppointment(AppointmentModel appointment) async {
    // Default to doctor 2 if not selected
    final doctorId = appointment.doctorId ?? 2;
    return await _api.bookAppointment(
      doctorId: doctorId,
      date: appointment.dateTime,
      notes: appointment.notes,
    );
  }
}
