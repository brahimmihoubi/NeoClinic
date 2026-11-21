import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/otpcontroller.dart';
import 'package:neoclinic/widgets/header_widget.dart';
class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Header(title: "OTP Verification"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const Text("Check your SMS and enter the 4-digit code."),
                  const SizedBox(height: 16),
                  TextField(
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    controller: controller.otpController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "----"),
                  ),
                  TextButton(
                    onPressed: () => controller.resendCode(),
                    child: const Text("Resend code"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => controller.verifyOtp(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3366FF),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("CONTINUE"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
