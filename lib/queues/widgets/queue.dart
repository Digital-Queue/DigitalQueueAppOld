import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:digital_queue/queues/widgets/dismissible_queue_item.dart';
import 'package:digital_queue/queues/widgets/empty_list_placeholder_widget.dart';
import 'package:digital_queue/queues/widgets/queue_item_widget.dart';
import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueuePage extends StatelessWidget {
  QueuePage({Key? key}) : super(key: key);

  final CourseQueue queue = Get.arguments['queue'] as CourseQueue;
  final QueueType queueType = Get.arguments['type'] as QueueType;
  final controller = Get.find<QueueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(queue.course),
      ),
      body: FutureBuilder(
        future: controller.getQueueItems(queue.courseId, queueType),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingWidget();
          }

          return Obx(
            () => Column(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    await controller.getQueueItems(queue.courseId, queueType);
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.queue.isEmpty ? 1 : controller.queue.length,
                    itemBuilder: (context, index) {
                      if (controller.queue.isEmpty && index == 0) {
                        return const EmptyListPlaceholderWidget();
                      }

                      if (queueType == QueueType.sent) {
                        return QueueItemWidget(
                          item: controller.queue.elementAt(index),
                        );
                      }

                      return DismissibleQueueItemWidget(
                        courseId: queue.courseId,
                        item: controller.queue.elementAt(index),
                        index: index,
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
