import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNameWidget extends StatelessWidget {
  const SetNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        children: [
          TextFormField(
            controller: controller.nameTextController,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 192,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                controller.executing.value = true;
                await controller.setName();
                controller.executing.value = false;
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
