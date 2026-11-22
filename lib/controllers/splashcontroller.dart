import 'dart:async';

import 'package:get/get.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/services/storage_services.dart';

class SplashController extends GetxController {
  final StorageService _storage = StorageService(); // ✅ THIS LINE IS REQUIRED

  @override
  void onInit() {
    super.onInit();
    _startAppFlow();
  }

  void _startAppFlow() async {
    await Future.delayed(Duration(seconds: 3));

    if (_storage.isFirstTime) {
      _storage.setFirstTimeFalse();
      Get.offAllNamed(AppRoutes.registration);
    } else if (_storage.isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
