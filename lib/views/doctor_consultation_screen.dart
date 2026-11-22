import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/routes/app_routes.dart';

class DoctorConsultationScreen extends StatefulWidget {
  @override
  State<DoctorConsultationScreen> createState() => _DoctorConsultationScreenState();
}

class _DoctorConsultationScreenState extends State<DoctorConsultationScreen> {
  final TextEditingController _subjCtrl = TextEditingController(
    text: 'Patient reports well-tolerated therapy. Occasional morning headaches noted. Good adherence to Lisinopril 10mg at bedtime.',
  );
  final TextEditingController _objCtrl = TextEditingController(
    text: 'BP: 120/78 mmHg (optimal control). HR: 72 bpm regular. Heart sounds S1/S2 normal without gallop. Recent lipid panel shows LDL at 142 mg/dL.',
  );
  final TextEditingController _assessCtrl = TextEditingController(
    text: '1. Essential (primary) hypertension [ICD-10 I10] - controlled.\n2. Mixed hyperlipidemia [ICD-10 E78.2].',
  );
  final TextEditingController _planCtrl = TextEditingController(
    text: '1. Refill Lisinopril 10mg daily x 30 days.\n2. Therapeutic lifestyle modifications (low sodium).\n3. Re-evaluate fasting lipid panel in 6 weeks.',
  );

  bool _allergySafetyChecked = true;
  bool _isSigned = false;

  @override
  void dispose() {
    _subjCtrl.dispose();
    _objCtrl.dispose();
    _assessCtrl.dispose();
    _planCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Clinical SOAP & Rx Writer', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar('Voice Dictation', 'Microphone active — dictating into clinical notes...', backgroundColor: AppColors.primary, colorText: Colors.white);
            },
            icon: const Icon(Icons.mic, color: AppColors.primary),
            tooltip: 'Dictate SOAP',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Header Bar (Sarah Jenkins)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primaryContainer,
                    child: Text('SJ', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sarah Jenkins • 54F', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        SizedBox(height: 2),
                        Text('MRN #94218 • Blood Type A+', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(8)),
                    child: const Text('Allergy: Penicillin', style: TextStyle(color: AppColors.emergency, fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ICD-10 Diagnosis Selector Tag
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: AppColors.primary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ICD-10 Primary Diagnosis: I10', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary)),
                        Text('Essential (primary) hypertension • Zero cross-reaction with Penicillin', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SOAP Note Sections
            _soapSection('S', 'Subjective (Patient History & Symptoms)', _subjCtrl),
            const SizedBox(height: 14),
            _soapSection('O', 'Objective (Vitals & Physical Exam)', _objCtrl),
            const SizedBox(height: 14),
            _soapSection('A', 'Assessment (Diagnostic Formulation)', _assessCtrl),
            const SizedBox(height: 14),
            _soapSection('P', 'Plan & Electronic Prescription (Rx)', _planCtrl),

            const SizedBox(height: 20),

            // Zero-Allergy Cross-Reaction Checkbox
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _allergySafetyChecked,
                    activeColor: AppColors.secondary,
                    onChanged: (val) => setState(() => _allergySafetyChecked = val ?? false),
                  ),
                  const Expanded(
                    child: Text(
                      'I have verified zero cross-reactivity with patient severe Penicillin allergy before digital signature.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sign & Transmit Button (Sequence B Step 3)
            ElevatedButton.icon(
              onPressed: _isSigned
                  ? null
                  : () {
                      setState(() => _isSigned = true);
                      Get.snackbar(
                        'Encounter Signed & Transmitted',
                        'Clinical SOAP note and Lisinopril Rx transmitted to Sarah Jenkins vault.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: AppColors.success,
                        colorText: Colors.white,
                        icon: const Icon(Icons.verified, color: Colors.white),
                      );
                      Future.delayed(const Duration(milliseconds: 1400), () {
                        Get.toNamed(AppRoutes.chatdetails);
                      });
                    },
              icon: Icon(_isSigned ? Icons.check_circle : Icons.draw_rounded),
              label: Text(
                _isSigned ? 'Signed by Dr. John Smith, MD' : 'Sign & Transmit to Patient Vault',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isSigned ? AppColors.success : AppColors.primary,
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

  Widget _soapSection(String badge, String title, TextEditingController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Center(child: Text(badge, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: ctrl,
            maxLines: 3,
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
            ),
          ),
        ],
      ),
    );
  }
}

