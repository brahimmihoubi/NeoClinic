import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/controllers/registrationcontroller.dart';
import 'package:neoclinic/widgets/header_widget.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Header(title: "Create Account"),
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
                  _textField("Full Name", controller.nameController),
                  _textField("Email", controller.emailController),
                  _textField("Phone Number", controller.phoneController),
                  _textField("Password", controller.passwordController, isPassword: true),
                  _textField("Confirm Password", controller.confirmPasswordController, isPassword: true),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => controller.register(),
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

  Widget _textField(String label, TextEditingController ctrl, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: ctrl,
        obscureText: isPassword,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
