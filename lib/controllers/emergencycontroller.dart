import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyController extends GetxController {
  final emergencyNumber = '12345678';

  void callEmergency() async {
    final Uri launchUri = Uri(scheme: 'tel', path: emergencyNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar('Error', 'Cannot launch phone dialer');
    }
  }
}