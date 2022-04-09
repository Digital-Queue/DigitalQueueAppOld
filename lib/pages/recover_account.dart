import 'package:digital_queue/controllers/recover_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RecoverAccountPage extends StatelessWidget {
  const RecoverAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecoverAccountController>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
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
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailTextController,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "Your email",
                          prefixIcon: Icon(Icons.email),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 210,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/reset-password");
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Send Reset Code',
                                style: TextStyle(fontSize: 18)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.send,
                              size: 32.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
