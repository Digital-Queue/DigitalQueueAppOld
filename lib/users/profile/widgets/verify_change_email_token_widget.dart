import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyChangeEmailTokenWidget extends StatelessWidget {
  const VerifyChangeEmailTokenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
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
                      onChanged: (String value) {},
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 210,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          controller.executing.value = true;
                          await controller.verifyCode();
                          controller.executing.value = false;
                        },
                        child: const Text(
                          'Confirm Email',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
