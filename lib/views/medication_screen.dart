import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/medicationcontroller.dart';

class MedicationScreen extends StatefulWidget {
  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final controller = Get.put(MedicationController());
  String _selectedDelivery = 'Same-Day Courier';
  bool _refillSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Prescription History & Refills', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Refill Due Alert Card (Sequence A Step 3)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _refillSubmitted ? AppColors.success : AppColors.warning),
                boxShadow: [
                  BoxShadow(
                    color: (_refillSubmitted ? AppColors.success : AppColors.warning).withValues(alpha: 0.1),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _refillSubmitted ? AppColors.successContainer : AppColors.warningContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _refillSubmitted ? 'ORDER SENT TO PHARMACY' : 'REFILL DUE — 4 DAYS REMAINING',
                          style: TextStyle(
                            color: _refillSubmitted ? AppColors.success : AppColors.warning,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const Text('Rx #89421', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.medication_rounded, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lisinopril 10mg Oral Tablet', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                            const SizedBox(height: 3),
                            Text('Prescribed by Dr. John Smith, MD • 30 Tablets', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                            const SizedBox(height: 2),
                            Text('Directions: Take 1 tablet by mouth daily at bedtime for blood pressure', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24, color: AppColors.border),

                  // Delivery Options
                  const Text('Select Delivery Method:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _deliveryOption('Same-Day Courier', 'Free (\$0.00)', Icons.delivery_dining_rounded),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _deliveryOption('In-Person Pickup', 'Pharmacy Desk', Icons.storefront_rounded),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Copay Breakdown (Sequence A spec)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _costRow('Retail Cost:', '\$55.00'),
                        const SizedBox(height: 4),
                        _costRow('BlueCross BlueShield A+ Coverage:', '-\$45.00', isDiscount: true),
                        const Divider(height: 12, color: AppColors.border),
                        _costRow('Patient Copay Required:', '\$10.00', isTotal: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Refill CTA
                  ElevatedButton.icon(
                    onPressed: _refillSubmitted
                        ? null
                        : () {
                            setState(() => _refillSubmitted = true);
                            Get.snackbar(
                              'Refill Transmitted',
                              'Lisinopril 10mg ordered via Same-Day Courier. Copay: \$10.00.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.success,
                              colorText: Colors.white,
                              icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                            );
                          },
                    icon: Icon(_refillSubmitted ? Icons.check_circle : Icons.send_rounded, size: 18),
                    label: Text(
                      _refillSubmitted ? 'Order Transmitted to Pharmacist' : 'Confirm & Send to Pharmacist (\$10.00)',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _refillSubmitted ? AppColors.success : AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Active Medications List
            const Text('Active Maintenance Prescriptions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _medicationCard('Metformin 500mg', 'Twice daily with meals • 60 Tablets', 'Refill in 22 days', AppColors.secondary),
            const SizedBox(height: 10),
            _medicationCard('Atorvastatin 20mg', 'Once daily at evening • 30 Tablets', 'Refill in 18 days', AppColors.primary),

            const SizedBox(height: 24),

            // 3. Allergy Contraindication Notice
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.emergency.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.do_not_disturb_on_rounded, color: AppColors.emergency, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contraindicated Allergies on File', style: TextStyle(color: AppColors.emergency, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 2),
                        Text('Penicillin & Amoxicillin (Severe Anaphylaxis) • Blocked from prescribing', style: TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliveryOption(String title, String subtitle, IconData icon) {
    final isSelected = _selectedDelivery == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedDelivery = title),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer.withValues(alpha: 0.4) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSelected ? AppColors.primary : AppColors.textPrimary)),
                  Text(subtitle, style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _costRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 13 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: FontWeight.bold,
            color: isDiscount ? AppColors.success : (isTotal ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _medicationCard(String title, String directions, String refillStatus, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.medication_outlined, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(directions, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(refillStatus, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
