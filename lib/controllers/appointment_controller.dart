import 'package:get/get.dart';
import '../models/appointment_model.dart';
import '../services/appointment_service.dart';

class AppointmentController extends GetxController {
  final AppointmentService _service = AppointmentService();
  var upcomingAppointments = <AppointmentModel>[].obs;
  var pastAppointments = <AppointmentModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  void fetchAppointments() async {
    isLoading.value = true;
    final appointments = await _service.fetchAppointments();
    upcomingAppointments.value = appointments.where((a) => a.isUpcoming).toList();
    pastAppointments.value = appointments.where((a) => !a.isUpcoming).toList();
    isLoading.value = false;
  }

  void bookAppointment(AppointmentModel appointment) async {
    isLoading.value = true;
    await _service.bookAppointment(appointment);
    fetchAppointments();
  }
}
