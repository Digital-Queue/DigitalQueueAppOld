import 'package:digital_queue/controllers/queue_controller.dart';
import 'package:digital_queue/pages/shared/loading_widget.dart';
import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QueueListPage extends StatelessWidget {
  QueueListPage({Key? key}) : super(key: key);

  final CourseQueue queue = Get.arguments as CourseQueue;
  final controller = Get.find<QueueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAndToNamed("/main", parameters: {
            "tab": "1",
          }),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(queue.course),
      ),
      body: FutureBuilder(
        future: controller.getQueueItems(queue.courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingWidget();
          }

          return Obx(
            () => Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: const Text(
                    "Swipe right to complete an item",
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 87, 87, 87),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    await controller.getQueueItems(queue.courseId);
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.queue.length,
                    itemBuilder: (context, index) {
                      return QueueItemWidget(
                        courseId: queue.courseId,
                        item: controller.queue.elementAt(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class QueueItemWidget extends StatelessWidget {
  final QueueItem item;
  final String courseId;
  const QueueItemWidget({
    Key? key,
    required this.item,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QueueController>(builder: (controller) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.startToEnd,
        dismissThresholds: const {
          DismissDirection.startToEnd: 0.2,
        },
        onDismissed: (direction) async {
          await Get.showOverlay(
            asyncFunction: () async {
              await controller.completeQueueItem(courseId, item.id);
            },
            loadingWidget: const LoadingWidget(),
            opacity: 0.6,
          );
        },
        confirmDismiss: (direction) async {
          return await Get.dialog<bool>(
            AlertDialog(
              content: const Text(
                "Confirm Completion",
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => Get.back(result: true),
                ),
                TextButton(
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => Get.back(result: false),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },
        background: Card(
          color: Colors.green.shade400,
          child: Container(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Mark Complete",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    "assets/student.svg",
                    height: 52,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    item.student!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
