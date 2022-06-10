import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/widgets/queues_list_widget.dart';
import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/queue_type.dart';

class QueuesPage extends StatelessWidget {
  final controller = Get.find<QueueController>();

  QueuesPage({Key? key}) : super(key: key);

  final pages = [
    () => GetBuilder<QueueController>(builder: (controller) {
          return QueuesListWidget(
            queues: controller.sent,
            refresh: controller.initialize,
            queueType: QueueType.sent,
          );
        }),
    () => GetBuilder<QueueController>(builder: (controller) {
          return QueuesListWidget(
            queues: controller.received,
            refresh: controller.initialize,
            queueType: QueueType.received,
          );
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingWidget();
        }

        // return list
        return Obx(
          () => Scaffold(
            body: pages.elementAt(controller.currentPageIndex.value)(),
            floatingActionButton: controller.showCreateActionButton.value
                ? _createItemActionButton()
                : null,
            bottomNavigationBar:
                controller.teacher.value ? _navigationMenu() : null,
          ),
        );
      },
    );
  }

  Widget _navigationMenu() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.outbond),
          label: "Sent",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: "Received",
        ),
      ],
      currentIndex: controller.currentPageIndex.value,
      onTap: (index) {
        controller.currentPageIndex.value = index;
        controller.showCreateActionButton.value = index == 0;
      },
    );
  }

  Widget _createItemActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed("/create");
      },
      backgroundColor: Colors.indigo,
      icon: const Icon(Icons.create),
      label: const Text("Create"),
    );
  }
}
