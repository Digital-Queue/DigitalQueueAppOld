import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/auth/widgets/choose_name_widget.dart';
import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseNamePage extends StatelessWidget {
  ChooseNamePage({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: const Text(
              "You're new here!\nEnter your full name so teachers can identify you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: SingleChildScrollView(
              child: Obx((() {
                if (controller.executing.value) {
                  return const LoadingWidget();
                }

                return const SetNameWidget();
              })),
            ),
          )
        ],
      ),
    );
  }
}
