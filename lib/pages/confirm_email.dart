import 'package:digital_queue/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmEmailPage extends StatelessWidget {
  ConfirmEmailPage({Key? key}) : super(key: key);

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
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
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Code",
                          prefixIcon: Icon(Icons.numbers),
                          fillColor: Colors.white,
                          filled: true),
                      onChanged: (String value) {
                        controller.confirmEmailCode.value = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 210,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/profile");
                        },
                        child: const Text('Confirm Email',
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
