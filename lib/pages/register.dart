import 'package:digital_queue/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset("assets/sign_up.png")),
              TextFormField(
                controller: controller.emailTextController,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                    fillColor: Colors.white,
                    filled: true),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.nameTextController,
                autocorrect: true,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.verified_user),
                    fillColor: Colors.white,
                    filled: true),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.passwordTextController,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    fillColor: Colors.white,
                    filled: true),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 192,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Create', style: TextStyle(fontSize: 18)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.login,
                        size: 32.0,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed("/login");
                  },
                  child: const Text(
                    "Already have account? Sign In",
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
