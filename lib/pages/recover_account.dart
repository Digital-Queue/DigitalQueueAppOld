import 'package:digital_queue/pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecoverAccountPage extends StatefulWidget {
  const RecoverAccountPage({Key? key}) : super(key: key);

  @override
  State<RecoverAccountPage> createState() => _RecoverAccountPageState();
}

class _RecoverAccountPageState extends State<RecoverAccountPage> {
  late final TextEditingController _emailFieldController;

  @override
  void initState() {
    _emailFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: SvgPicture.asset("assets/mail.svg"),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                TextField(
                  controller: _emailFieldController,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Your email",
                      prefixIcon: Icon(Icons.email),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ResetPasswordPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Send Reset Code', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.send,
                          size: 32.0,
                        ),
                      ],
                    ),
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
