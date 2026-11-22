import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neoclinic/bindings/initial_binding.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/routes/app_screens.dart';
import 'package:neoclinic/services/storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Register StorageService globally
  Get.put(StorageService());

  runApp(NeoClinicApp());
}

class NeoClinicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NeoClinic Precision Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primaryContainer,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondaryContainer,
          surface: AppColors.surface,
          error: AppColors.emergency,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.splash,
      getPages: getPages,
    );
  }
}
