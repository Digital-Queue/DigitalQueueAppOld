import 'package:digital_queue/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.exit,
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
              showEmailNotConfirmedCard(),
              const Divider(),
              const Center(
                heightFactor: 1.2,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: controller.changePassword,
                child: const Text(
                  "Change Password",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card showEmailNotConfirmedCard() {
    return Card(
      color: Colors.amber[50],
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          if (!controller.emailConfirmed.value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.warning,
                        ),
                        Text(
                          "Your e-mail address is not confirmed.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: controller.confirmEmail,
                        style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.yellow.shade600),
                        ),
                        child: const Text("Confirm Now"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Column();
          }
        },
      ),
    );
  }
}
