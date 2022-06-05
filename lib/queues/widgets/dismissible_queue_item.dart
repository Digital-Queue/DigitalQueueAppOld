import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/models/queue_item.dart';
import 'package:digital_queue/queues/widgets/queue_item_widget.dart';
import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DismissibleQueueItemWidget extends StatelessWidget {
  final QueueItem item;
  final String courseId;
  final int index;

  const DismissibleQueueItemWidget({
    Key? key,
    required this.item,
    required this.courseId,
    required this.index,
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
          controller.queue.removeAt(index);
          bool undo = await _waitUserForUndo();

          if (undo) {
            controller.queue.insert(index, item);
            return;
          }

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
        child: QueueItemWidget(item: item),
      );
    });
  }

  Future<bool> _waitUserForUndo() async {
    bool undo = false;
    await Get.showSnackbar(GetSnackBar(
      messageText: const Text(
        "Tap to undo",
      ),
      backgroundColor: Colors.white,
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeInExpo,
      showProgressIndicator: true,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(seconds: 1),
      onTap: (snackbar) {
        undo = true;
        Get.closeCurrentSnackbar();
      },
    )).future;

    return undo;
  }
}
