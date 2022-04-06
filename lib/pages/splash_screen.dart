import 'package:digital_queue/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const MyHomePage();

            default:
              return Scaffold(
                body: Center(
                  child: SvgPicture.asset("assets/logo.svg"),
                ),
              );
          }
        });
  }

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
