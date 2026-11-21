import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // Check if app is opened for the first time
  bool get isFirstTime => _box.read('first_time') ?? true;
  void setFirstTimeFalse() => _box.write('first_time', false);

  // Check if user is logged in
  bool get isLoggedIn => _box.read('logged_in') ?? false;
  void setLoggedIn(bool value) => _box.write('logged_in', value);
}
