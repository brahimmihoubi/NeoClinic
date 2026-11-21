import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neoclinic/bindings/initial_binding.dart';
import 'routes/app_screens.dart';
import 'routes/app_routes.dart';
import 'services/storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // 🔐 Must be called before using GetStorage

  // ✅ Register the StorageService globally
  Get.put(StorageService());

  runApp(NeoClinicApp());
}

class NeoClinicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neo Clinic',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(), // <-- Set up initial bindings
      initialRoute: AppRoutes.splash,
      getPages: getPages,
    );
  }
}
