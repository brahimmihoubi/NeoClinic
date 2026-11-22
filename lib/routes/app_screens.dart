import 'package:get/get.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/views/appointments_screen.dart';
import 'package:neoclinic/views/appointmentsbooking_screen.dart';
import 'package:neoclinic/views/appointmentsdetails_screen.dart';
import 'package:neoclinic/views/biologist_validation_screen.dart';
import 'package:neoclinic/views/chatdetails_screen.dart';
import 'package:neoclinic/views/doctor_consultation_screen.dart';
import 'package:neoclinic/views/doctor_queue_screen.dart';
import 'package:neoclinic/views/emergency_screen.dart';
import 'package:neoclinic/views/homepage_screen.dart';
import 'package:neoclinic/views/login_screen.dart';
import 'package:neoclinic/views/medicalrecords_screen.dart';
import 'package:neoclinic/views/medication_screen.dart';
import 'package:neoclinic/views/otp_screen.dart';
import 'package:neoclinic/views/profile_screen.dart';
import 'package:neoclinic/views/recordsdetails_screen.dart';
import 'package:neoclinic/views/register_screen.dart';
import 'package:neoclinic/views/splash_screen.dart';
import 'package:neoclinic/views/uploadrecords_screen.dart';

final getPages = [
  // 01: Gateway / Auth
  GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.registration, page: () => RegistrationScreen()),
  GetPage(name: AppRoutes.otp, page: () => OtpScreen()),

  // 02: Home & Vitals Dashboard
  GetPage(name: AppRoutes.home, page: () => HomePageScreen()),

  // 03: Specialist & Booking Hub
  GetPage(name: AppRoutes.appointments, page: () => AppointmentsScreen()),
  GetPage(name: AppRoutes.appointmentsbooking, page: () => AppointmentBookingScreen()),
  GetPage(name: AppRoutes.appointmentsdetails, page: () => const AppointmentDetailScreen()),

  // 04: Health Records & Lab Vault
  GetPage(name: AppRoutes.medicalrecords, page: () => MedicalRecordsScreen()),
  GetPage(name: AppRoutes.records, page: () => MedicalRecordsScreen()),
  GetPage(name: AppRoutes.recordsdetails, page: () => const RecordDetailScreen(record: null)),

  // 05: Telehealth & Chat
  GetPage(name: AppRoutes.chatdetails, page: () => ChatDetailScreen()),
  GetPage(name: AppRoutes.messages, page: () => ChatDetailScreen()),

  // 06: Emergency SOS & Urgent Dispatch
  GetPage(name: AppRoutes.emergency, page: () => EmergencyScreen()),

  // 07: Prescription History & Refills
  GetPage(name: AppRoutes.medication, page: () => MedicationScreen()),
  GetPage(name: AppRoutes.prescriptions, page: () => MedicationScreen()),

  // 08: Document Upload & AI Scanner
  GetPage(name: AppRoutes.uploadrecords, page: () => UploadRecordScreen()),

  // 09: Doctor Queue & Suite Manager
  GetPage(name: AppRoutes.doctorQueue, page: () => DoctorQueueScreen()),

  // 10: Clinical Notes & SOAP Writer
  GetPage(name: AppRoutes.doctorConsultation, page: () => DoctorConsultationScreen()),

  // 11: Biologist Lab Validation Portal
  GetPage(name: AppRoutes.biologistValidation, page: () => BiologistValidationScreen()),

  // 12: Patient Profile & Settings
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
];
