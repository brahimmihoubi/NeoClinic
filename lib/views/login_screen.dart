import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/authcontroller.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/widgets/logo_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  bool _obscurePassword = true;
  String _selectedRole = 'patient';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Clinical Gradient Header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary.withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'PRECISION HEALTH v1.0',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                          ),
                        ),
                        // Quick SOS Trigger
                        InkWell(
                          onTap: () => Get.toNamed(AppRoutes.emergency),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.emergency,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.emergency.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.emergency, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text('SOS (14)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 76,
                      height: 76,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const LogoWidget(size: 52, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'NeoClinic',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Where Innovation Protects Your Health',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 2. Role Switcher Tabs (Gateway: Patient / Doctor / Lab)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      _roleTab('patient', 'Patient', Icons.person_outline),
                      _roleTab('doctor', 'Doctor', Icons.medical_services_outlined),
                      _roleTab('biologist', 'Lab Analyst', Icons.biotech_outlined),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 3. Form Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedRole == 'patient'
                            ? 'Welcome back, Patient'
                            : _selectedRole == 'doctor'
                                ? 'Clinician Suite Portal'
                                : 'Laboratory Validation Portal',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter your medical credentials to access your health vault',
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 20),

                      // Email / Identifier field
                      TextFormField(
                        controller: controller.phoneController,
                        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Email Address / Phone',
                          labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary, size: 20),
                          filled: true,
                          fillColor: AppColors.background,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textSecondary, size: 20),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => controller.resetPassword(),
                          child: const Text('Forgot password?', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Sign In Primary CTA
                      Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : () => controller.login(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                              )
                            : const Text('Sign In Securely', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      )),

                      const SizedBox(height: 14),

                      // 1-Tap Biometric FaceID Trigger (Sequence A requirement)
                      OutlinedButton.icon(
                        onPressed: () {
                          // Preset default demo patient credentials and sign in instantly
                          if (_selectedRole == 'patient') {
                            controller.phoneController.text = 'patient1@healthcare.com';
                            controller.passwordController.text = 'patient123';
                          } else if (_selectedRole == 'doctor') {
                            controller.phoneController.text = 'doctor1@healthcare.com';
                            controller.passwordController.text = 'doctor123';
                          } else {
                            controller.phoneController.text = 'biologist1@healthcare.com';
                            controller.passwordController.text = 'biologist123';
                          }
                          Get.snackbar(
                            'FaceID Verified',
                            'Biometric token confirmed for Sarah Jenkins',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: AppColors.secondary,
                            colorText: Colors.white,
                            icon: const Icon(Icons.face_unlock_rounded, color: Colors.white),
                          );
                          controller.login();
                        },
                        icon: const Icon(Icons.fingerprint_rounded, color: AppColors.secondary),
                        label: const Text('1-Tap FaceID / Biometric Login', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: const BorderSide(color: AppColors.secondary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bottom register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New to NeoClinic?", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.registration),
                    child: const Text('Create an Account', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleTab(String role, String label, IconData icon) {
    final isSelected = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedRole = role;
            if (role == 'patient') {
              controller.phoneController.text = 'patient1@healthcare.com';
              controller.passwordController.text = 'patient123';
            } else if (role == 'doctor') {
              controller.phoneController.text = 'doctor1@healthcare.com';
              controller.passwordController.text = 'doctor123';
            } else {
              controller.phoneController.text = 'biologist1@healthcare.com';
              controller.passwordController.text = 'biologist123';
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : AppColors.textSecondary),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
