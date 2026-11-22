import 'package:get/get.dart';
import 'package:neoclinic/services/api_service.dart';

class HomePageController extends GetxController {
  final ApiService api = ApiService();

  var loading = false.obs;
  var appointments = <String>[].obs;
  var records = <String>[].obs;
  var messages = <String>[].obs;
  var monitoring = <String>[].obs;
  var reminders = <String>[].obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  void loadAllData() async {
    loading.value = true;
    try {
      final appts = await api.fetchUpcomingAppointments();
      appointments.value = appts;

      final recs = await api.fetchMedicalRecords();
      records.value = recs.map((r) => '${r.title} — ${r.type}').toList();

      final msgs = await api.fetchMessages();
      messages.value = msgs.map((m) => m.content).toList();
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      loading.value = false;
    }
  }

  void onSectionTap(String section) {
    Get.toNamed('/$section');
  }
}
