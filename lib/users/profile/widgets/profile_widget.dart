import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  heightFactor: 1.5,
                  child: SvgPicture.asset(
                    "assets/user.svg",
                    height: 96,
                  ),
                ),
                const Center(
                  heightFactor: 2,
                  child: Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          controller.name.value,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Divider(),
                        Text(
                          controller.email.value,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const Center(
                  heightFactor: 1.2,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.goToChangeEmail();
                  },
                  child: const Text(
                    "Change Email",
                  ),
                ),
                ElevatedButton(
                  onPressed: () async => controller.signOut(),
                  child: const Text(
                    "Log Out",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
