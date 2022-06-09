import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:digital_queue/users/profile/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed("/main");
          },
        ),
      ),
      body: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const ProfileWidget();
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
