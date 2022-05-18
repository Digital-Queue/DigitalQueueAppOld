import 'package:digital_queue/controllers/queue_controller.dart';
import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueuesWidget extends StatelessWidget {
  QueuesWidget({Key? key}) : super(key: key);

  final controller = Get.find<QueueController>();

  final pages = [
    () => GetBuilder<QueueController>(builder: (controller) {
          return QueuesListWidget(queues: controller.sent);
        }),
    () => GetBuilder<QueueController>(builder: (controller) {
          return QueuesListWidget(queues: controller.received);
        }),
  ];

  final _currentPageIndex = 0.obs;
  final _showCreateActionButton = true.obs;

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
            body: pages.elementAt(_currentPageIndex.value)(),
            floatingActionButton: _showCreateActionButton.value
                ? _createItemActionButton()
                : null,
            bottomNavigationBar: controller.teacher ? _navigationMenu() : null,
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
      currentIndex: _currentPageIndex.value,
      onTap: (index) {
        _currentPageIndex.value = index;
        _showCreateActionButton.value = index == 0;
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

class QueuesListWidget extends StatelessWidget {
  final List<CourseQueue> queues;

  const QueuesListWidget({Key? key, required this.queues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QueueController>(builder: (controller) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.initialize();
        },
        child: ListView.builder(
          itemCount: queues.length,
          itemBuilder: (context, index) {
            return CourseQueueItemWidget(
              queue: queues.elementAt(index),
            );
          },
        ),
      );
    });
  }
}

class CourseQueueItemWidget extends StatelessWidget {
  final CourseQueue queue;

  const CourseQueueItemWidget({
    Key? key,
    required this.queue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    queue.course,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Tap to view queue",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                "${queue.total} Pending",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
