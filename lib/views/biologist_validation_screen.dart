import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';

class BiologistValidationScreen extends StatefulWidget {
  @override
  State<BiologistValidationScreen> createState() => _BiologistValidationScreenState();
}

class _BiologistValidationScreenState extends State<BiologistValidationScreen> {
  bool _isValidated = false;

  final List<Map<String, dynamic>> _analytes = [
    {
      'test': 'Total Cholesterol',
      'result': '224',
      'unit': 'mg/dL',
      'range': '< 200',
      'flag': 'HIGH',
      'color': AppColors.warning,
      'bg': AppColors.warningContainer,
    },
    {
      'test': 'LDL Cholesterol (Direct)',
      'result': '142',
      'unit': 'mg/dL',
      'range': '< 100',
      'flag': 'ABNORMAL',
      'color': AppColors.emergency,
      'bg': const Color(0xFFFEE2E2),
    },
    {
      'test': 'HDL Cholesterol',
      'result': '56',
      'unit': 'mg/dL',
      'range': '> 50',
      'flag': 'NORMAL',
      'color': AppColors.success,
      'bg': AppColors.successContainer,
    },
    {
      'test': 'Triglycerides',
      'result': '130',
      'unit': 'mg/dL',
      'range': '< 150',
      'flag': 'NORMAL',
      'color': AppColors.success,
      'bg': AppColors.successContainer,
    },
    {
      'test': 'Fasting Blood Glucose',
      'result': '98',
      'unit': 'mg/dL',
      'range': '70 – 99',
      'flag': 'NORMAL',
      'color': AppColors.success,
      'bg': AppColors.successContainer,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Biologist Lab Validation Portal', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sample Specimen Header
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, Color(0xFF065F46)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: AppColors.secondary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
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
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                        child: const Text('CLIA CERTIFICATE #45D2189412', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _isValidated ? 'CERTIFIED & SIGNED' : 'PENDING BIOLOGIST',
                          style: TextStyle(color: _isValidated ? const Color(0xFF86EFAC) : Colors.amberAccent, fontSize: 10, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text('Specimen #BIO-94218 • Serum Lipid Panel', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Patient: Sarah Jenkins (54F) • Ordering Physician: Dr. John Smith, MD', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
                    child: const Text('Spectrometry Equipment: Cobas c501 Analyzer (Calibrated)', style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text('Analyte Spectrometry Results Table', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 12),

            // Analytes Table
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _analytes.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, index) {
                  final a = _analytes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a['test'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
                              Text('Ref: ${a['range']} ${a['unit']}', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('${a['result']} ${a['unit']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: a['bg'], borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            a['flag'],
                            style: TextStyle(color: a['color'], fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Diagnostic Interpretation Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Senior Biologist Technical Interpretation', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Text(
                    'Elevated LDL at 142 mg/dL with Total Cholesterol at 224 mg/dL indicates primary hyperlipidemia. No hemolysis detected. Specimen integrity 100% verified for clinical decision support.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Authorize CTA (SCREEN_19)
            ElevatedButton.icon(
              onPressed: _isValidated
                  ? null
                  : () {
                      setState(() => _isValidated = true);
                      Get.snackbar(
                        'CLIA Certificate Certified',
                        'Laboratory results signed and broadcasted to Sarah Jenkins & Dr. Smith.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppColors.secondary,
                        colorText: Colors.white,
                        icon: const Icon(Icons.verified, color: Colors.white),
                      );
                    },
              icon: Icon(_isValidated ? Icons.check_circle : Icons.verified_user_rounded),
              label: Text(
                _isValidated ? 'CLIA Certified & Synced' : 'Authorize & Sign Laboratory Certificate',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isValidated ? AppColors.secondary : AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
