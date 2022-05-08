import 'package:flutter/material.dart';

class ConfirmCodePage extends StatelessWidget {
  const ConfirmCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: "Code",
                              prefixIcon: Icon(Icons.numbers),
                              fillColor: Colors.white,
                              filled: true),
                          onChanged: (String value) {},
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: 210,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Confirm Email',
                                style: TextStyle(fontSize: 18)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
