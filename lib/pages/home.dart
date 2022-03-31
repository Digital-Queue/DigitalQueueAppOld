import 'dart:ui';

import 'package:digital_queue/pages/login.dart';
import 'package:digital_queue/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String mainScreenImageFile = 'assets/main_screen.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      /*
      appBar: AppBar(
        title: const Text("Digital Queue"),
        elevation: 5,
        centerTitle: true,
        toolbarHeight: 72,
      ),
      */
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // image
            Center(
              child: SizedBox(
                child: SvgPicture.asset(mainScreenImageFile),
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                SizedBox(
                  width: 192,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Sign In', style: TextStyle(fontSize: 18)),
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
                  height: 16,
                ),
                SizedBox(
                  width: 192,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Create Account', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
