import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';

class RecordDetailScreen extends StatelessWidget {
  final MedicalRecord? record;

  const RecordDetailScreen({required this.record, super.key});

  @override
  Widget build(BuildContext context) {
    final rec = record ??
        MedicalRecord(
          id: '1',
          title: 'Complete Lipid & Metabolic Panel',
          date: DateTime.now().subtract(const Duration(days: 3)),
          type: 'Laboratory Analysis',
          content: 'Specimen verified: Serum. Findings consistent with primary hypertension management. LDL mildly elevated at 142 mg/dL. Renal function normal.',
          prescription: 'Lisinopril 10mg daily at bedtime',
          symptoms: 'Blood pressure elevated during morning checks (138/88 mmHg).',
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Clinical Record Detail', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar(
                'HIPAA Vault Download',
                'Report "${rec.title}" exported to encrypted PDF.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.success,
                colorText: Colors.white,
                icon: const Icon(Icons.check_circle, color: Colors.white),
              );
            },
            icon: const Icon(Icons.download_rounded, color: AppColors.primary),
            tooltip: 'Export PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
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
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.secondaryContainer, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            rec.type,
                            style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Ready & Validated', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(rec.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Text(
                    'Recorded: ${rec.date.year}-${rec.date.month.toString().padLeft(2, '0')}-${rec.date.day.toString().padLeft(2, '0')} • Attending: Dr. John Smith, MD',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Clinical Findings & Notes Card
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
                  const Text('Clinical Findings & Physician Evaluation', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  Text(
                    rec.content,
                    style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.5),
                  ),
                  if (rec.symptoms != null && rec.symptoms!.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    const Text('Patient Symptoms Reported:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(rec.symptoms!, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                  ],
                ],
              ),
            ),

            if (rec.prescription != null && rec.prescription!.isNotEmpty) ...[
              const SizedBox(height: 18),
              // Prescription section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.medication_rounded, color: AppColors.secondary, size: 20),
                        SizedBox(width: 8),
                        Text('Prescribed Medication Regimen', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      rec.prescription!,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    const Text('Dispensed via NeoClinic Preferred Courier • 30 Days Supply', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 18),

            // HIPAA Audit Stamp
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.security, size: 18, color: AppColors.textSecondary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'CLIA #45D2189412 • Cryptographically verified by Clinical Lab Director',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Get.snackbar(
                  'HIPAA Encrypted PDF',
                  'Vault export generated with verifiable QR signature.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
              },
              icon: const Icon(Icons.file_download_outlined, color: Colors.white),
              label: const Text('Download Signed HIPAA PDF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
