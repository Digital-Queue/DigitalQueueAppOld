import 'package:digital_queue/pages/login.dart';
import 'package:digital_queue/pages/recover_account.dart';
import 'package:digital_queue/pages/register.dart';
import 'package:digital_queue/pages/reset_password.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Queue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.indigo[50]),
      home: FutureBuilder(
          future: initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return const LoginPage();

                  default:
                    return Scaffold(
                      body: Center(
                        child: SvgPicture.asset("assets/logo.svg"),
                      ),
                    );
                }
          }),
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/recover-account": (context) => const RecoverAccountPage(),
        "/reset-password": (context) => const ResetPasswordPage()
      },
    );
  }

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
