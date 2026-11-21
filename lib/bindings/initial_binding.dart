import 'package:get/get.dart';
import 'package:neoclinic/controllers/emergencycontroller.dart';
import 'package:neoclinic/controllers/medicationcontroller.dart';
import 'package:neoclinic/controllers/profilecontroller.dart';
import '../controllers/homepagecontroller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Register your global controllers here
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => EmergencyController());
    Get.lazyPut(() => MedicationController());
    Get.lazyPut(() => HomePageController());
  }
}
