import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeEmailWidget extends StatelessWidget {
  const ChangeEmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          children: [
            TextFormField(
              controller: controller.emailTextController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Your new email",
                  prefixIcon: Icon(Icons.email),
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
                onPressed: () async {
                  controller.executing.value = true;
                  await controller.getCode();
                  controller.executing.value = false;
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Send Code',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.send,
                      size: 32.0,
                    ),
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
