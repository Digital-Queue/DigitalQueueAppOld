import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:digital_queue/queues/widgets/course_queue_item_widget.dart';
import 'package:digital_queue/queues/widgets/empty_list_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
