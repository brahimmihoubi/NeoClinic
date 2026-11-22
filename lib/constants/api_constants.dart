import 'package:get_storage/get_storage.dart';

class ApiConstants {
  static final GetStorage _box = GetStorage();

  // Allows overriding the host IP (e.g. for physical devices on local Wi-Fi)
  static String get baseUrl {
    final customUrl = _box.read('custom_api_url');
    if (customUrl != null && customUrl.toString().trim().isNotEmpty) {
      return customUrl.toString().trim();
    }

    // With `adb reverse tcp:8000 tcp:8000` active, localhost:8000 works on both
    // physical devices, emulators, and local machines seamlessly.
    // Wi-Fi LAN direct fallback: http://192.168.100.8:8000/api
    return 'http://localhost:8000/api';
  }

  // Endpoints
  static String get login => '$baseUrl/auth/login';
  static String get register => '$baseUrl/auth/register';
  static String get appointments => '$baseUrl/appointments';
  static String get medicalRecords => '$baseUrl/medical-records';
  static String get messages => '$baseUrl/messages';
  static String user(int id) => '$baseUrl/users/$id';
}

