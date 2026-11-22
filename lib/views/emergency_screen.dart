import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/emergencycontroller.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final controller = Get.put(EmergencyController());
  final bool _broadcasting = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF2F2), // Light emergency container
      appBar: AppBar(
        title: const Text('Emergency SOS & Dispatch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppColors.emergency,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. High Urgency Alert Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.emergency.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(color: AppColors.emergency.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Color(0xFFFEE2E2), shape: BoxShape.circle),
                    child: const Icon(Icons.warning_amber_rounded, color: AppColors.emergency, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CRITICAL MEDICAL BEACON', style: TextStyle(color: AppColors.emergency, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                        SizedBox(height: 2),
                        Text('Immediate paramedic dispatch with telemetry sync', style: TextStyle(color: AppColors.textPrimary, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Large Circular SOS Dial Button (2-Sec Hold or Tap)
            GestureDetector(
              onLongPress: () {
                controller.callEmergency();
                Get.snackbar('SOS Broadcasted', 'Dialing Paramedics & EMS Dispatch...', backgroundColor: AppColors.emergency, colorText: Colors.white);
              },
              onTap: controller.callEmergency,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    colors: [Color(0xFFEF4444), AppColors.emergency],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emergency.withValues(alpha: 0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call, color: Colors.white, size: 48),
                    SizedBox(height: 6),
                    Text('CALL (14)', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Hold 2s / Tap', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // 3. Automated Payload Broadcast Card (Sequence C spec)
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
                      const Text('Automated Telemetry Payload', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      Row(
                        children: [
                          Icon(Icons.radar, color: _broadcasting ? AppColors.emergency : AppColors.textSecondary, size: 16),
                          const SizedBox(width: 4),
                          Text(_broadcasting ? 'LIVE STREAM' : 'OFFLINE', style: TextStyle(color: _broadcasting ? AppColors.emergency : AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: AppColors.border),
                  _payloadRow(Icons.person, 'Patient Name', 'Sarah Jenkins (Age 54)'),
                  const SizedBox(height: 8),
                  _payloadRow(Icons.bloodtype, 'Blood Type', 'A+ (Confirmed)'),
                  const SizedBox(height: 8),
                  _payloadRow(Icons.warning, 'Severe Allergy Warning', 'PENICILLIN (Anaphylaxis Risk)', valueColor: AppColors.emergency),
                  const SizedBox(height: 8),
                  _payloadRow(Icons.location_on, 'Live GPS Coordinates', '30.2672° N, 97.7431° W (Austin EMS Anchor)'),
                  const SizedBox(height: 8),
                  _payloadRow(Icons.monitor_heart, 'Current Vitals Snapshot', 'BP 120/78 mmHg • HR 72 bpm'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. Emergency Contacts Quick Dial
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
                  const Text('Emergency Contacts', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 12),
                  _contactTile('Mark Jenkins', 'Spouse • Primary Contact', '+1 (512) 555-0199', () => controller.callEmergency()),
                  const Divider(height: 16, color: AppColors.border),
                  _contactTile('Dr. John Smith, MD', 'Attending Cardiologist', '+1 (512) 555-0144', () => controller.callEmergency()),
                  const Divider(height: 16, color: AppColors.border),
                  _contactTile('Central Emergency Ambulance', 'EMS Dispatch (14)', '14', () => controller.callEmergency()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payloadRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: valueColor ?? AppColors.textSecondary),
        const SizedBox(width: 8),
        Text('$label: ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valueColor ?? AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _contactTile(String name, String role, String phone, VoidCallback onCall) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(role, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onCall,
          icon: const Icon(Icons.call, size: 14, color: Colors.white),
          label: const Text('Call', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.emergency,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            minimumSize: const Size(0, 32),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
