import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/auth/controllers/auth_controller.dart';
import 'package:digital_queue/users/auth/widgets/verify_token_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyAuthPage extends StatelessWidget {
  VerifyAuthPage({Key? key}) : super(key: key);

  final controller = Get.put(AuthController());

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/sign_up.png",
                    height: 300,
                    width: 300,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Form(
                    key: const Key("verify_auth_form"),
                    child: Obx(
                      () {
                        if (controller.executing.value) {
                          return const LoadingWidget();
                        }

                        return const VerifyTokenWidget();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
