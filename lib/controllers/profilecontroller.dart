import 'package:get/get.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/services/storage_services.dart';

class ProfileController extends GetxController {
  final StorageService _storage = StorageService();

  var userName = 'Patient'.obs;
  var userEmail = ''.obs;
  var userRole = 'patient'.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    final name = _storage.userName;
    final email = _storage.userEmail;
    final role = _storage.userRole;

    userName.value = name.isNotEmpty ? name : 'Patient';
    userEmail.value = email;
    userRole.value = role;
  }

  void logout() {
    _storage.clearSession();
    Get.offAllNamed(AppRoutes.login);
  }
}
