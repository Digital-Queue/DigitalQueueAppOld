import 'package:digital_queue/bindings/application_binding.dart';
import 'package:digital_queue/controllers/main_controller.dart';
import 'package:digital_queue/firebase_options.dart';
import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/pages/auth/auth.dart';
import 'package:digital_queue/pages/auth/set_name.dart';
import 'package:digital_queue/pages/auth/verify_auth.dart';
import 'package:digital_queue/pages/auth/profile.dart';
import 'package:digital_queue/pages/change_email/change_email.dart';
import 'package:digital_queue/pages/change_email/confirm_code.dart';
import 'package:digital_queue/pages/queue/queue.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final controller = Get.put(MainController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return GetMaterialApp(
      title: 'Digital Queue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.indigo[50],
      ),
      home: _showStartScreen(),
      getPages: [
        GetPage(
          name: "/auth",
          page: () => AuthPage(),
        ),
        GetPage(
          name: "/verifyAuth",
          page: () => VerifyAuthPage(),
        ),
        GetPage(
          name: "/profile",
          page: () => ProfilePage(),
        ),
        GetPage(
          name: "/setName",
          page: () => SetNamePage(),
        ),
        GetPage(
          name: "/changeEmail",
          page: () => ChangeEmailPage(),
        ),
        GetPage(
          name: "/confirmCode",
          page: () => ConfirmCodePage(),
        ),
        GetPage(
          name: "/queue",
          page: () => QueuePage(),
        )
      ],
      initialBinding: ApplicationBindings(),
    );
  }

  FutureBuilder<dynamic> _showStartScreen() {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // We have a user, go to profile view.
            if (snapshot.data is User) {
              return ProfilePage();
            }

            // we do not have user data, user needs to
            // authenticate.
            return AuthPage();

          default:
            return _showSplashScreen();
        }
      },
    );
  }

  Scaffold _showSplashScreen() {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/logo.svg",
        ),
      ),
    );
  }
}
