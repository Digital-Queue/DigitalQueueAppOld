import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final controller = Get.put(AuthController());
  var _isLoggingIn = false.obs;

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
                    child: Obx(() {
                      if (_isLoggingIn.value) {
                        return const LoadingWidget();
                      }

                      return _showAuthWidget();
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

  Column _showAuthWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Enter your email",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: controller.emailTextController,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "E-mail",
            prefixIcon: Icon(
              Icons.email,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            _isLoggingIn.value = true;
            await controller.authenticate();
            _isLoggingIn.value = false;
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Get Code',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.send_rounded,
                size: 32.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
