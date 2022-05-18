import 'package:digital_queue/controllers/queue_controller.dart';
import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseQueueWidget extends StatelessWidget {
  CourseQueueWidget({Key? key}) : super(key: key);

  final controller = Get.find<QueueController>();

  final pages = const [
    SentQueuesWidget(),
    ReceivedQueuesWidget(),
  ];

  final _currentPageIndex = 0.obs;
  final _showCreateActionButton = true.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: controller.isTeacher(),
      builder: (context, snapshot) {
        var showNavigationMenu = false;
        if (snapshot.data is bool) {
          showNavigationMenu = snapshot.data!;
        }

        return Obx(
          () => Scaffold(
            body: pages.elementAt(_currentPageIndex.value),
            floatingActionButton: _showCreateActionButton.value
                ? _createItemActionButton()
                : null,
            bottomNavigationBar: showNavigationMenu ? _navigationMenu() : null,
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

class ReceivedQueuesWidget extends StatelessWidget {
  const ReceivedQueuesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Hello!")),
    );
  }
}

class SentQueuesWidget extends StatelessWidget {
  const SentQueuesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QueueController>(builder: (controller) {
      return FutureBuilder(
        future: controller.getQueues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data as List<CourseQueue>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CourseQueueItemWidget(
                  queue: data.elementAt(index),
                );
              },
            );
          }

          return const LoadingWidget();
        },
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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
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
      ),
    );
  }
}
