import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neoclinic/services/api_service.dart';

class MyHttpOverrides extends HttpOverrides {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    HttpOverrides.global = MyHttpOverrides();
    final tempDir = Directory.systemTemp.createTempSync();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        return tempDir.path;
      },
    );
    await GetStorage.init();
  });

  test('Integration test: authenticate and fetch backend data', () async {
    final api = ApiService();

    // 1. Authenticate with live backend
    final loginRes = await api.login('patient1@healthcare.com', 'patient123');
    expect(loginRes['success'], isTrue, reason: 'Failed to login: ${loginRes['message']}');

    // 2. Fetch appointments
    final appointments = await api.fetchAppointments();
    expect(appointments, isNotEmpty, reason: 'Appointments should not be empty');
    expect(appointments.first.id, equals('1'));

    // 3. Fetch medical records
    final records = await api.fetchMedicalRecords();
    expect(records, isNotEmpty, reason: 'Medical records should not be empty');
    expect(records.first.title, contains('Hypertension'));
  });
}
