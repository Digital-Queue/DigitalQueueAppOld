import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNamePage extends StatelessWidget {
  const SetNamePage({Key? key}) : super(key: key);

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
              child: Column(
                children: [
                  TextFormField(
                    // controller:
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
                      onPressed: () {
                        Get.offNamed("/queue");
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
