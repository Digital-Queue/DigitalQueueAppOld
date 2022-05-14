import 'package:digital_queue/controllers/change_mail_controller.dart';
import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class ConfirmCodePage extends StatelessWidget {
  ConfirmCodePage({Key? key}) : super(key: key);

  final controller = Get.put(ChangeEmailController());

  var _isProcessing = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            child: Obx(() {
              if (_isProcessing.value) {
                return const LoadingWidget();
              }

              return _showCodeWidget();
            }),
          ),
        ),
      ),
    );
  }

  Column _showCodeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Image.asset(
            "assets/sign_up.png",
            height: 250,
            width: 250,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: controller.codeTextController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Code",
                      prefixIcon: Icon(Icons.numbers),
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (String value) {},
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
                      await controller.verifyCode();
                      _isProcessing.value = false;
                    },
                    child: const Text(
                      'Confirm Email',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
