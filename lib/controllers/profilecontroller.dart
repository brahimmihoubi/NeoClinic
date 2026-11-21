import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = 'John Doe'.obs;
  var userEmail = 'johndoe@example.com'.obs;

  void logout() {
    // Clear user session and navigate to login
    Get.offAllNamed('/login');
  }
}