import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/queue_type.dart';

class QueuesWidget extends StatelessWidget {
  final controller = Get.find<QueueController>();

  QueuesWidget({Key? key}) : super(key: key);

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

class QueuesListWidget extends StatelessWidget {
  final List<CourseQueue> queues;
  final Future<void> Function() refresh;
  final QueueType queueType;

  const QueuesListWidget({
    Key? key,
    required this.queues,
    required this.refresh,
    required this.queueType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: ListView.builder(
          itemCount: queues.isEmpty ? 1 : queues.length,
          itemBuilder: (context, index) {
            if (queues.isEmpty && index == 0) {
              return const EmptyListPlaceholderWidget();
            }
            return CourseQueueItemWidget(
              queue: queues.elementAt(index),
              queueType: queueType,
            );
          },
        ),
      ),
    );
  }
}

class EmptyListPlaceholderWidget extends StatelessWidget {
  const EmptyListPlaceholderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset("assets/empty.svg"),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Queue is empty, pull down to refresh...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 128, 128, 128),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseQueueItemWidget extends StatelessWidget {
  final CourseQueue queue;
  final QueueType queueType;
  final controller = Get.find<QueueController>();

  CourseQueueItemWidget({
    Key? key,
    required this.queueType,
    required this.queue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/queue", arguments: {
          "queue": queue,
          "type": queueType,
        });
      },
      child: Card(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: SvgPicture.asset(
                  "assets/checklist.svg",
                  height: 48,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      queue.course,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${queue.total} Pending - Tap to view",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
