import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:digital_queue/users/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangeEmailPage extends StatelessWidget {
  ChangeEmailPage({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());
  final _isProcessing = false.obs;

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
                      if (_isProcessing.value) {
                        return const LoadingWidget();
                      }

                      return _showChangeEmailWidget();
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

  Column _showChangeEmailWidget() {
    return Column(
      children: [
        TextFormField(
          controller: controller.emailTextController,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              labelText: "Your new email",
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
            onPressed: () async {
              _isProcessing.value = true;
              await controller.getCode();
              _isProcessing.value = false;
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Send Code',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
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
    );
  }
}