import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/appointment_controller.dart';
import 'package:neoclinic/models/appointment_model.dart';

class AppointmentBookingScreen extends StatefulWidget {
  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final controller = Get.find<AppointmentController>();

  int _selectedDoctorId = 2;
  String _selectedDoctorName = 'Dr. John Smith';
  String _selectedSpecialty = 'Cardiology';

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTimeSlot = '10:30 AM';
  final TextEditingController _notesController = TextEditingController();

  final List<Map<String, dynamic>> _doctors = [
    {
      'id': 2,
      'name': 'Dr. John Smith',
      'specialty': 'Cardiology',
      'rating': '4.9',
      'reviews': '128 reviews',
      'suite': 'Suite 304',
    },
    {
      'id': 3,
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Pediatrics',
      'rating': '4.8',
      'reviews': '94 reviews',
      'suite': 'Suite 210',
    },
  ];

  final List<String> _timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:30 AM',
    '11:00 AM',
    '02:00 PM',
    '03:30 PM',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Schedule Consultation', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP 1: Select Attending Specialist
            _stepHeader('1', 'Select Attending Specialist'),
            const SizedBox(height: 12),
            ..._doctors.map((doc) {
              final isSelected = _selectedDoctorId == doc['id'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDoctorId = doc['id'];
                    _selectedDoctorName = doc['name'];
                    _selectedSpecialty = doc['specialty'];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: isSelected ? AppColors.primaryContainer : AppColors.background,
                        child: Icon(Icons.person, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doc['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Text('${doc['specialty']} • ${doc['suite']}', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 2),
                              Text(doc['rating'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                          Text(doc['reviews'], style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // STEP 2: Pick Consultation Date
            _stepHeader('2', 'Select Consultation Date'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Consultation Date', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                              Text(
                                '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    icon: const Icon(Icons.edit_calendar, size: 16),
                    label: const Text('Change Date'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // STEP 3: Choose Time Slot
            _stepHeader('3', 'Available Time Slots'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _timeSlots.map((slot) {
                final isSelected = _selectedTimeSlot == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedTimeSlot = slot);
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // STEP 4: Symptoms & Notes
            _stepHeader('4', 'Reason for Visit / Symptoms'),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g., Routine checkup, follow-up on hypertension, or new symptoms...',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
              ),
            ),

            const SizedBox(height: 28),

            // Confirm Button
            ElevatedButton(
              onPressed: () {
                final appointment = AppointmentModel(
                  id: '',
                  doctorId: _selectedDoctorId,
                  doctorName: _selectedDoctorName,
                  dateTime: _selectedDate,
                  notes: _notesController.text.trim().isEmpty ? 'Regular consultation' : _notesController.text.trim(),
                  isUpcoming: true,
                  status: 'scheduled',
                  type: 'consultation',
                );

                controller.bookAppointment(appointment);
                Get.back();
                Get.snackbar(
                  'Appointment Confirmed',
                  'Booked $_selectedSpecialty with $_selectedDoctorName on $_selectedTimeSlot',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.success,
                  colorText: Colors.white,
                  icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Confirm & Schedule Visit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _stepHeader(String number, String title) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          child: Center(
            child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
      ],
    );
  }
}
