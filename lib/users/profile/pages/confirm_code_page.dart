import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:digital_queue/users/profile/widgets/verify_change_email_token_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmCodePage extends StatelessWidget {
  ConfirmCodePage({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  final _isProcessing = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight,
              ),
              child: Obx(() {
                if (_isProcessing.value) {
                  return const LoadingWidget();
                }

                return const VerifyChangeEmailTokenWidget();
              }),
            ),
          );
        },
      ),
    );
  }
}
