import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/queue_controller.dart';

class QueuePage extends StatelessWidget {
  QueuePage({Key? key}) : super(key: key);

  final QueueController controller = Get.put(QueueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed("/create");
        },
        backgroundColor: Colors.indigo,
        icon: const Icon(Icons.create),
        label: Text("Create"),
      ),
    );
  }
}
