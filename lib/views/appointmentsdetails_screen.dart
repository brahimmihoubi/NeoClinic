import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/models/appointment_model.dart';
import 'package:neoclinic/routes/app_routes.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final AppointmentModel? appointment;

  const AppointmentDetailScreen({this.appointment, super.key});

  String _cleanDocName(String raw) {
    if (raw.startsWith('Dr. Dr.')) return raw.replaceFirst('Dr. Dr.', 'Dr.');
    if (!raw.startsWith('Dr.') && !raw.startsWith('Doctor')) return 'Dr. $raw';
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final appt = appointment ??
        AppointmentModel(
          id: '1',
          doctorName: 'Dr. John Smith',
          dateTime: DateTime.now().add(const Duration(days: 2)),
          notes: 'Routine hypertension and lipid panel review',
          isUpcoming: true,
          status: 'scheduled',
        );

    final cleanName = _cleanDocName(appt.doctorName);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Consultation Details', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.successContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Confirmed • Electronic Check-in Active',
                      style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Doctor Profile Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryContainer,
                    child: Icon(Icons.person, color: AppColors.primary, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cleanName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        const SizedBox(height: 4),
                        Text('Cardiology Specialist', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        const SizedBox(height: 4),
                        const Text('Clinic Suite 304 • Main Tower', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.chatdetails),
                    icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary),
                    style: IconButton.styleFrom(backgroundColor: AppColors.primaryContainer),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Visit Time & Location
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.calendar_today_rounded, 'Date', '${appt.dateTime.year}-${appt.dateTime.month.toString().padLeft(2, '0')}-${appt.dateTime.day.toString().padLeft(2, '0')}'),
                  const Divider(height: 24, color: AppColors.border),
                  _infoRow(Icons.access_time_rounded, 'Time', '10:30 AM (30 min slot)'),
                  const Divider(height: 24, color: AppColors.border),
                  _infoRow(Icons.location_on_outlined, 'Location', 'NeoClinic Downtown Medical Center, Floor 3'),
                  const Divider(height: 24, color: AppColors.border),
                  _infoRow(Icons.medical_services_outlined, 'Type', 'In-Person Consultation'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Clinical Notes
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Clinical Preparation & Notes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Text(
                    appt.notes.isNotEmpty ? appt.notes : 'Please bring previous test results and list of current medications.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.chatdetails),
                    icon: const Icon(Icons.message, size: 16),
                    label: const Text('Message'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Cancel Consultation?',
                        middleText: 'Are you sure you want to cancel your visit with $cleanName?',
                        textConfirm: 'Yes, Cancel',
                        textCancel: 'Keep Visit',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.emergency,
                        onConfirm: () {
                          Get.back();
                          Get.back();
                          Get.snackbar('Cancelled', 'Consultation has been cancelled.', snackPosition: SnackPosition.BOTTOM);
                        },
                      );
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: const Text('Cancel Visit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emergency,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
