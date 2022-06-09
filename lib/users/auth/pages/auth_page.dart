import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/auth/controllers/auth_controller.dart';
import 'package:digital_queue/users/auth/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

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
                  child: SvgPicture.asset(
                    "assets/login.svg",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  alignment: Alignment.topCenter,
                  child: Form(
                    key: const Key("auth_form"),
                    child: GetBuilder<AuthController>(builder: (controller) {
                      return Obx(() {
                        if (controller.executing.value) {
                          return const LoadingWidget();
                        }

                        return const AuthWidget();
                      });
                    }),
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
