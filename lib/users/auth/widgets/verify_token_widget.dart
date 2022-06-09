import 'package:digital_queue/users/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyTokenWidget extends StatelessWidget {
  const VerifyTokenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Column(
          children: [
            const Text(
              "Enter code sent your inbox",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: controller.codeTextController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Code",
                  prefixIcon: Icon(
                    Icons.numbers,
                  ),
                  fillColor: Colors.white,
                  filled: true),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 192,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  controller.executing.value = true;
                  await controller.verifyAuthToken();
                  controller.executing.value = false;
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.login,
                      size: 32.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
