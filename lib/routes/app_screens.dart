import 'package:get/get.dart';
import 'package:neoclinic/views/appointments_screen.dart';
import 'package:neoclinic/views/appointmentsbooking_screen.dart';
import 'package:neoclinic/views/appointmentsdetails_screen.dart';
import 'package:neoclinic/views/chatdetails_screen.dart';
import 'package:neoclinic/views/emergency_screen.dart';
import 'package:neoclinic/views/homepage_screen.dart';
import 'package:neoclinic/views/login_screen.dart';
import 'package:neoclinic/views/medicalrecords_screen.dart';
import 'package:neoclinic/views/recordsdetails_screen.dart';
import 'package:neoclinic/views/medication_screen.dart';
import 'package:neoclinic/views/otp_screen.dart';
import 'package:neoclinic/views/profile_screen.dart';
import 'package:neoclinic/views/register_screen.dart';
import 'package:neoclinic/views/splash_screen.dart';
import 'package:neoclinic/views/uploadrecords_screen.dart';
import 'app_routes.dart';

final getPages = [
  GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.registration, page: () => RegistrationScreen()),
  GetPage(name: AppRoutes.otp, page: () => OtpScreen()),
  GetPage(name: AppRoutes.home, page: () => HomePageScreen()),
  GetPage(name: AppRoutes.appointments, page: () => AppointmentsScreen()),
  GetPage(name: AppRoutes.appointmentsbooking, page: () => AppointmentBookingScreen()),
  GetPage(name: AppRoutes.appointmentsdetails, page: () => AppointmentDetailScreen(appointment: null,)),
  GetPage(name: AppRoutes.chatdetails, page: () => ChatDetailScreen()),
  GetPage(name: AppRoutes.medicalrecords, page: () => MedicalRecordsScreen()),
  GetPage(name: AppRoutes.recordsdetails, page: () => RecordDetailScreen(record: null,)),
  GetPage(name: AppRoutes.uploadrecords, page: () => UploadRecordScreen()),
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  GetPage(name: AppRoutes.emergency, page: () => EmergencyScreen()),
  GetPage(name: AppRoutes.medication, page: () => MedicationScreen()),
];
