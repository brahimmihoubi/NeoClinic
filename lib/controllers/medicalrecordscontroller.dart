import 'package:get/get.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';
import 'package:neoclinic/services/api_service.dart';

class MedicalRecordsController extends GetxController {
  final ApiService _apiService = ApiService();

  var records = <MedicalRecord>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }

  List<MedicalRecord> get filteredRecords => records
      .where((record) => record.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                         record.content.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  void fetchRecords() async {
    isLoading.value = true;
    try {
      final list = await _apiService.fetchMedicalRecords();
      records.value = list;
    } finally {
      isLoading.value = false;
    }
  }

  void addRecord(MedicalRecord record) {
    records.add(record);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}
