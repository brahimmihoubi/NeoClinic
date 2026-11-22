import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // First time opening the app
  bool get isFirstTime => _box.read('first_time') ?? true;
  void setFirstTimeFalse() => _box.write('first_time', false);

  // Auth Token
  String? get token => _box.read('auth_token');
  void saveToken(String token) {
    _box.write('auth_token', token);
    _box.write('logged_in', true);
  }

  // User Profile
  Map<String, dynamic>? get user {
    final data = _box.read('auth_user');
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  void saveUser(Map<String, dynamic> user) => _box.write('auth_user', user);

  int? get userId => user?['id'];
  String get userName => '${user?['first_name'] ?? ''} ${user?['last_name'] ?? ''}'.trim();
  String get userEmail => user?['email'] ?? '';
  String get userRole => user?['role'] ?? 'patient';

  // Check if user is logged in
  bool get isLoggedIn => token != null && token!.isNotEmpty;
  void setLoggedIn(bool value) => _box.write('logged_in', value);

  // Clear Session
  void clearSession() {
    _box.remove('auth_token');
    _box.remove('auth_user');
    _box.write('logged_in', false);
  }
}
