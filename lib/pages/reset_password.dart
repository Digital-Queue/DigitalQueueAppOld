import 'package:digital_queue/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController _codeFieldController;
  late final TextEditingController _passwordFieldController;

  @override
  void initState() {
    _codeFieldController = TextEditingController();
    _passwordFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _codeFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                TextField(
                  controller: _codeFieldController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Code",
                      prefixIcon: Icon(Icons.numbers),
                      fillColor: Colors.white,
                      filled: true),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _passwordFieldController,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "New Password",
                      prefixIcon: Icon(Icons.password),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: const Text('Change Password',
                        style: TextStyle(fontSize: 18)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
