import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:digital_queue/users/profile/widgets/change_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangeEmailPage extends StatelessWidget {
  ChangeEmailPage({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: SvgPicture.asset("assets/mail.svg"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Form(
                    child: Obx(() {
                      if (controller.executing.value) {
                        return const LoadingWidget();
                      }

                      return const ChangeEmailWidget();
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
