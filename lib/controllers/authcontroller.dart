import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var phoneError = ''.obs;
  var passwordError = ''.obs;
  var isLoading = false.obs;

  void login() async {
    bool hasError = false;
    final input = phoneController.text.trim();
    final password = passwordController.text;

    if (input.isEmpty) {
      phoneError.value = "Please enter your email or phone";
      hasError = true;
    } else {
      phoneError.value = "";
    }

    if (password.isEmpty) {
      passwordError.value = "Please enter your password";
      hasError = true;
    } else {
      passwordError.value = "";
    }

    if (hasError) return;

    isLoading.value = true;
    try {
      final result = await _apiService.login(input, password);
      if (result['success'] == true) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'Login Failed',
          result['message'] ?? 'Invalid credentials',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void resetPassword() {
    Get.snackbar(
      'Reset Password',
      'Please contact administrator to reset your password.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
