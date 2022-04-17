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
            icon: const Icon(Icons.arrow_back), onPressed: controller.exit),
        actions: [
          IconButton(onPressed: controller.save, icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: SvgPicture.asset(
                  "assets/profile.svg",
                  height: 96,
                )),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Details",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true),
                      initialValue: controller.name.value,
                      onChanged: (String value) =>
                          controller.name.value = value,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          fillColor: Colors.white,
                          filled: true),
                      initialValue: controller.email.value,
                      onChanged: (String value) =>
                          controller.email.value = value,
                    ),
                    Container(
                      child:
                          GetBuilder<ProfileController>(builder: (controller) {
                        if (!controller.emailConfirmed.value) {
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: controller.confirmEmail,
                                    child: const Text("Confirm Email")),
                              ),
                            ],
                          );
                        } else {
                          return Row();
                        }
                      }),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Password",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    ElevatedButton(
                        onPressed: controller.changePassword,
                        child: const Text("Change Password"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
