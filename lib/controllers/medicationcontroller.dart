import 'package:get/get.dart';

class MedicationReminder {
  String name;
  String time;

  MedicationReminder({required this.name, required this.time});
}

class MedicationController extends GetxController {
  var reminders = <MedicationReminder>[].obs;

  void addReminder(String name, String time) {
    reminders.add(MedicationReminder(name: name, time: time));
  }

  void removeReminder(int index) {
    reminders.removeAt(index);
  }
}
