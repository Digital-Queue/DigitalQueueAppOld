import 'package:digital_queue/controllers/set_name_controller.dart';
import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNamePage extends StatelessWidget {
  SetNamePage({Key? key}) : super(key: key);

  final controller = Get.put(SetNameController());
  var _isProcessing = false.obs;

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
                if (_isProcessing.value) {
                  return LoadingWidget();
                }

                return _showSetNameWidget();
              })),
            ),
          )
        ],
      ),
    );
  }

  Column _showSetNameWidget() {
    return Column(
      children: [
        TextFormField(
          controller: controller.nameTextController,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "Name",
            prefixIcon: Icon(Icons.person),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 192,
          height: 48,
          child: ElevatedButton(
            onPressed: () async {
              _isProcessing.value = true;
              await controller.setName();
              _isProcessing.value = false;
            },
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
