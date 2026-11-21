import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/authcontroller.dart';
import 'package:neoclinic/widgets/header_widget.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Header(title: "NeoClinic"),
          Expanded(
            child:
             Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  _PhoneField(controller),
                  const SizedBox(height: 12),
                  _PasswordField(controller),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Forgot password?"),
                      TextButton(
                        onPressed: () => controller.resetPassword(),
                        child: const Text("Reset password", style: TextStyle(color: Colors.blue)),
                      )
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => controller.login(),
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

  Widget _PhoneField(AuthController controller) {
    return TextFormField(
      controller: controller.phoneController,
      decoration: const InputDecoration(labelText: "Phone number"),
    );
  }

  Widget _PasswordField(AuthController controller) {
    return TextFormField(
      controller: controller.passwordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: "Password"),
    );
  }
}
