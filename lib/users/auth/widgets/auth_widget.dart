import 'package:digital_queue/users/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter your email",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: controller.emailTextController,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "E-mail",
              prefixIcon: Icon(
                Icons.email,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              controller.executing.value = true;
              await controller.getAuthToken();
              controller.executing.value = false;
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Get Code',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.send_rounded,
                  size: 32.0,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
