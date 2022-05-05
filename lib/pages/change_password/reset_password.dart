import 'package:digital_queue/controllers/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Image.asset(
                "assets/sign_up.png",
                height: 250,
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.codeTextController,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Code",
                          prefixIcon: Icon(Icons.numbers),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: controller.newPasswordTextController,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "New Password",
                          prefixIcon: Icon(Icons.password),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 210,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/login");
                        },
                        child: const Text('Change Password',
                            style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
