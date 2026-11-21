import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart'; // Make sure this import exists

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var phoneError = ''.obs;
  var passwordError = ''.obs;

  void login() {
    bool hasError = false;

    if (phoneController.text.isEmpty) {
      phoneError.value = "Please enter your phone number";
      hasError = true;
    } else {
      phoneError.value = "";
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = "Please enter your password";
      hasError = true;
    } else {
      passwordError.value = "";
    }

    if (!hasError) {
      // Here you could add actual login logic or API call
      // Simulate successful login:
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void resetPassword() {
    // You can navigate to a password reset screen or trigger an API
    // Example: Get.toNamed(AppRoutes.resetPassword);
  }
}
