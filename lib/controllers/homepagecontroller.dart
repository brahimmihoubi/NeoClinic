import 'package:get/get.dart';
import '../services/api_service.dart';

class HomePageController extends GetxController {
  final api = ApiService();

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
      appointments.value = await api.fetchUpcomingAppointments();
      // Similarly fill other sections...
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      loading.value = false;
    }
  }

  void onSectionTap(String section) {
    // Navigate to detail pages, e.g.:
    Get.toNamed('/$section');
  }
}
