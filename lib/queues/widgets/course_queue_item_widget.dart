import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
