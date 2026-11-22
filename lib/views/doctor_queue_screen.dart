import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/routes/app_routes.dart';

class DoctorQueueScreen extends StatefulWidget {
  @override
  State<DoctorQueueScreen> createState() => _DoctorQueueScreenState();
}

class _DoctorQueueScreenState extends State<DoctorQueueScreen> {
  final List<Map<String, dynamic>> _patients = [
    {
      'id': 1,
      'name': 'Sarah Jenkins',
      'age': 54,
      'blood': 'A+',
      'allergy': 'Penicillin (Severe)',
      'time': '10:30 AM',
      'wait': '4 mins wait',
      'type': 'In-Person Consultation',
      'reason': 'Hypertension & Lipid Panel Follow-up',
      'status': 'Ready in Suite 304',
      'isNext': true,
    },
    {
      'id': 2,
      'name': 'Michael Davis',
      'age': 62,
      'blood': 'O+',
      'allergy': 'None',
      'time': '11:15 AM',
      'wait': 'On Schedule',
      'type': 'Telehealth Video',
      'reason': 'Post-Stent Routine Review',
      'status': 'Virtual Waiting Room',
      'isNext': false,
    },
    {
      'id': 3,
      'name': 'Emily Clark',
      'age': 38,
      'blood': 'B+',
      'allergy': 'Sulfa drugs',
      'time': '11:45 AM',
      'wait': 'Checked In',
      'type': 'In-Person Consultation',
      'reason': 'Arrhythmia Palpitations',
      'status': 'Vitals Captured',
      'isNext': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Doctor Queue & Suite 304', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Suite Header Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF0038A8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.medical_services, color: AppColors.primary, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dr. John Smith, MD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 2),
                        Text('Chief of Clinical Cardiology • Suite 304', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                          child: const Text('Clinic Schedule: 3 Patients Waiting', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Morning Clinical Triage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.secondaryContainer, borderRadius: BorderRadius.circular(8)),
                  child: const Text('On Time', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Queue List (Sequence B step 2: Dr. Smith admits Sarah Jenkins)
            ..._patients.map((p) {
              final isNext = p['isNext'] == true;
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isNext ? AppColors.primary : AppColors.border, width: isNext ? 2 : 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
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
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: isNext ? AppColors.primaryContainer : AppColors.background,
                                child: Text(
                                  p['name'].toString().split(' ').map((e) => e[0]).join(),
                                  style: TextStyle(color: isNext ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('${p['age']} yrs • Blood ${p['blood']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isNext ? AppColors.primaryContainer : AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(p['time'], style: TextStyle(color: isNext ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),

                    const Divider(height: 20, color: AppColors.border),

                    Row(
                      children: [
                        const Icon(Icons.assignment_outlined, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Expanded(child: Text(p['reason'], style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
                      ],
                    ),

                    if (p['allergy'] != 'None') ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.emergency),
                          const SizedBox(width: 6),
                          Text('Allergy: ${p['allergy']}', style: const TextStyle(fontSize: 12, color: AppColors.emergency, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Call in button (Sequence B Step 2)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.toNamed(AppRoutes.doctorConsultation);
                            },
                            icon: const Icon(Icons.login_rounded, size: 18),
                            label: Text(
                              isNext ? 'Admit Sarah Jenkins (Suite 304)' : 'Open Patient Chart',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isNext ? AppColors.primary : AppColors.surface,
                              foregroundColor: isNext ? Colors.white : AppColors.primary,
                              elevation: 0,
                              side: isNext ? null : const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

