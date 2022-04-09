import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: const Key("login_form"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/login.svg"),
                const SizedBox(
                  height: 32,
                ),
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
                  controller: controller.passwordTextController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                      fillColor: Colors.white,
                      filled: true),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 192,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Login', style: TextStyle(fontSize: 18)),
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
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed("/recover-account");
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 16),
                    )),
                TextButton(
                    onPressed: () {
                      Get.toNamed("/register");
                    },
                    child: const Text(
                      "Don't have account? create one.",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
