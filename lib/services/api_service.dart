import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neoclinic/constants/api_constants.dart';
import 'package:neoclinic/models/appointment_model.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';
import 'package:neoclinic/models/message_model.dart';
import 'package:neoclinic/services/storage_services.dart';

class ApiService {
  final StorageService _storage = StorageService();

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final token = _storage.token;
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // --- AUTHENTICATION ---

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.trim(),
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data['token'] != null) {
          _storage.saveToken(data['token']);
        }
        if (data['user'] != null) {
          _storage.saveUser(Map<String, dynamic>.from(data['user']));
        }
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Cannot connect to server: $e'};
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.trim(),
          'password': password,
          'role': 'patient',
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'phone': phone?.trim() ?? '',
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data['token'] != null) {
          _storage.saveToken(data['token']);
        }
        if (data['user'] != null) {
          _storage.saveUser(Map<String, dynamic>.from(data['user']));
        }
        return {'success': true, 'data': data};
      } else {
        String msg = data['message'] ?? 'Registration failed';
        if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
          msg = (data['errors'] as List).map((e) => e['msg'] ?? e['path']).join(', ');
        }
        return {'success': false, 'message': msg};
      }
    } catch (e) {
      return {'success': false, 'message': 'Cannot connect to server: $e'};
    }
  }

  // --- APPOINTMENTS ---

  Future<List<AppointmentModel>> fetchAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.appointments),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((json) => AppointmentModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> fetchUpcomingAppointments() async {
    final appointments = await fetchAppointments();
    final upcoming = appointments.where((a) => a.isUpcoming).toList();
    if (upcoming.isEmpty) return [];
    return upcoming.map((a) => '${a.doctorName} — ${a.dateTime.month}/${a.dateTime.day} (${a.notes})').toList();
  }

  Future<bool> bookAppointment({
    required int doctorId,
    required DateTime date,
    String? notes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.appointments),
        headers: _headers,
        body: jsonEncode({
          'doctor_id': doctorId,
          'appointment_date': date.toIso8601String(),
          'notes': notes ?? '',
        }),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  // --- MEDICAL RECORDS ---

  Future<List<MedicalRecord>> fetchMedicalRecords() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.medicalRecords),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((json) => MedicalRecord.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // --- MESSAGES ---

  Future<List<MessageModel>> fetchMessages({int? conversationId}) async {
    try {
      final url = conversationId != null
          ? '${ApiConstants.messages}?conversation=$conversationId'
          : ApiConstants.messages;
      final response = await http.get(
        Uri.parse(url),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        final currentUserId = _storage.userId ?? 0;
        return list.map((json) => MessageModel.fromJson(json, currentUserId)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> sendMessage({
    required int receiverId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.messages),
        headers: _headers,
        body: jsonEncode({
          'receiver_id': receiverId,
          'content': content,
        }),
      );
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }
}
