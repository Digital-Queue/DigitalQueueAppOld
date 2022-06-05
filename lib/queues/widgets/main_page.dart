import 'package:digital_queue/queues/widgets/queues.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/queue_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final QueueController controller = Get.put(QueueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queues"),
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
      body: QueuesPage(),
    );
  }
}
