import 'package:digital_queue/pages/recover_account.dart';
import 'package:digital_queue/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/login.svg"),
            const SizedBox(
              height: 32,
            ),
            TextField(
              controller: _emailTextController,
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
            TextField(
              controller: _passwordTextController,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RecoverAccountPage()));
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()));
                },
                child: const Text(
                  "Don't have account? create one.",
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
