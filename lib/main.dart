import 'dart:developer';

import 'package:digital_queue/firebase_options.dart';
import 'package:digital_queue/queues/widgets/create_queue_item.dart';
import 'package:digital_queue/queues/widgets/main_page.dart';
import 'package:digital_queue/queues/widgets/queue_list_page.dart';
import 'package:digital_queue/shared/services/backend_service.dart';
import 'package:digital_queue/shared/services/notifications_service.dart';
import 'package:digital_queue/users/auth/widgets/auth.dart';
import 'package:digital_queue/users/auth/widgets/set_name.dart';
import 'package:digital_queue/users/auth/widgets/verify_auth.dart';
import 'package:digital_queue/users/profile/widgets/change_email.dart';
import 'package:digital_queue/users/profile/widgets/confirm_code.dart';
import 'package:digital_queue/users/profile/widgets/profile.dart';
import 'package:digital_queue/users/services/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init firebase token change notifier
  FirebaseMessaging.instance.onTokenRefresh.listen(
    (token) async {
      const cache = FlutterSecureStorage();
      await cache.write(key: 'user_device_token', value: token);
    },
  );

  // handler firebase notifications
  final notificationService = Get.put(NotificationService());
  await notificationService.initialize();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    notificationService.show(notification!);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final userService = Get.put(UserService());

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
          page: () => ChooseNamePage(),
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
          name: "/main",
          page: () => MainPage(),
        ),
        GetPage(
          name: "/create",
          page: () => CreateQueueItemPage(),
        ),
        GetPage(
          name: "/queue",
          page: () => QueuePage(),
        )
      ],
    );
  }

  FutureBuilder<dynamic> _showStartScreen() {
    return FutureBuilder(
      future: userService.initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // We have a user, go to main
            final response = snapshot.data as BackendResponse?;

            // we do not have user data, user needs to
            // authenticate.
            if (response == null) {
              return AuthPage();
            }

            if (response.error == true) {
              return AuthPage();
            }

            log(response.data["accessToken"]);
            return MainPage();

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
