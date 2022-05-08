import 'package:digital_queue/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    controller.initialize();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAndToNamed("/queue");
          },
        ),
      ),
      body: SingleChildScrollView(
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
                  Get.toNamed("/changeEmail");
                },
                child: const Text(
                  "Change Email",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offNamed("/auth");
                },
                child: const Text(
                  "Log Out",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
