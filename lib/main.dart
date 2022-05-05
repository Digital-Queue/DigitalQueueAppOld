import 'package:digital_queue/bindings/application_binding.dart';
import 'package:digital_queue/controllers/main_controller.dart';
import 'package:digital_queue/models/user.dart';
import 'package:digital_queue/models/user_type_adapter.dart';
import 'package:digital_queue/pages/auth/auth.dart';
import 'package:digital_queue/pages/auth/set_name.dart';
import 'package:digital_queue/pages/auth/verify_auth.dart';
import 'package:digital_queue/pages/auth/profile.dart';
import 'package:digital_queue/pages/change_email/change_email.dart';
import 'package:digital_queue/pages/change_email/confirm_code.dart';
import 'package:digital_queue/pages/queue/queue.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter<User>(UserAdapter());

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
      home: FutureBuilder(
        future: controller.initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null) {
                // we do not have user data, user needs to
                // authenticate.
                return AuthPage();
              }

              // We have a user, go to profile view.
              return ProfilePage();

            default:
              return Scaffold(
                body: Center(
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                  ),
                ),
              );
          }
        },
      ),
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
}
