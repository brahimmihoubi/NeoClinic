import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/profilecontroller.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());
  bool _biometricEnabled = true;
  bool _wearableSync = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Patient Profile & Settings', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Patient Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.primaryContainer,
                        child: Text('SJ', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                          child: const Icon(Icons.check, color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                    controller.userName.value.isNotEmpty ? controller.userName.value : 'Sarah Jenkins',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  )),
                  const SizedBox(height: 2),
                  Obx(() => Text(
                    controller.userEmail.value.isNotEmpty ? controller.userEmail.value : 'patient1@healthcare.com',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  )),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _badge('Blood Type: A+', AppColors.secondaryContainer, AppColors.secondary),
                      _badge('MRN #94218', AppColors.primaryContainer, AppColors.primary),
                      _badge('Insured: BlueCross', const Color(0xFFF1F5F9), AppColors.textPrimary),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Emergency Medical ID
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.medical_information_outlined, color: AppColors.emergency, size: 20),
                      SizedBox(width: 8),
                      Text('Emergency Medical ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                  const Divider(height: 20, color: AppColors.border),
                  _idRow('Primary Condition', 'Essential Hypertension (Controlled)'),
                  const SizedBox(height: 8),
                  _idRow('Severe Allergies', 'Penicillin (Anaphylaxis Warning)', isAlert: true),
                  const SizedBox(height: 8),
                  _idRow('Emergency Contact', 'Mark Jenkins (Spouse) • +1 (512) 555-0199'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Wearable Devices Sync
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.watch_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Wearable Devices Sync',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: _wearableSync,
                        activeThumbColor: AppColors.primary,
                        onChanged: (val) => setState(() => _wearableSync = val),
                      ),
                    ],
                  ),
                  const Divider(height: 16, color: AppColors.border),
                  _deviceTile('Dexcom G7 Continuous Glucose', 'Real-time telemetry • 98 mg/dL', Icons.sensors),
                  const SizedBox(height: 10),
                  _deviceTile('Omron Evolv Wireless BP Monitor', 'Last synced 8:00 AM • 120/78 mmHg', Icons.monitor_heart_rounded),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. Security & Biometrics
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Security & Privacy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                  const Divider(height: 20, color: AppColors.border),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.fingerprint_rounded, color: AppColors.secondary, size: 22),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'Biometric 2FA (FaceID)',
                                style: TextStyle(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: _biometricEnabled,
                        activeThumbColor: AppColors.secondary,
                        onChanged: (val) => setState(() => _biometricEnabled = val),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: AppColors.border),
                  const Row(
                    children: [
                      Icon(Icons.lock_outline, color: AppColors.textSecondary, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'HIPAA 256-bit AES encryption active for health vault',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Sign Out?',
                  middleText: 'Are you sure you want to end your session?',
                  textConfirm: 'Sign Out',
                  textCancel: 'Cancel',
                  confirmTextColor: Colors.white,
                  buttonColor: AppColors.emergency,
                  onConfirm: () {
                    Get.back();
                    controller.logout();
                  },
                );
              },
              icon: const Icon(Icons.logout_rounded, size: 18),
              label: const Text('Sign Out Securely', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEE2E2),
                foregroundColor: AppColors.emergency,
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textCol)),
    );
  }

  Widget _idRow(String label, String value, {bool isAlert = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isAlert ? AppColors.emergency : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _deviceTile(String name, String sub, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
              Text(sub, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const Icon(Icons.check_circle, color: AppColors.success, size: 18),
      ],
    );
  }
}
