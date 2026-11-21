import 'package:get/get.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';

class MedicalRecordsController extends GetxController {
  var records = <MedicalRecord>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  List<MedicalRecord> get filteredRecords => records
      .where((record) => record.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  void fetchRecords() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 1));
    records.value = [
      MedicalRecord(title: 'Blood Test', date: DateTime.now(), type: 'Lab Result', content: 'Normal values'),
      MedicalRecord(title: 'X-Ray Chest', date: DateTime.now().subtract(Duration(days: 3)), type: 'Imaging', content: 'Clear lungs'),
    ];
    isLoading.value = false;
  }

  void addRecord(MedicalRecord record) {
    records.add(record);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}