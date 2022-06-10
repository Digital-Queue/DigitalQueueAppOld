import 'package:digital_queue/queues/controllers/queue_controller.dart';
import 'package:digital_queue/queues/widgets/search_course_widget.dart';
import 'package:digital_queue/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CreateQueueItemPage extends StatelessWidget {
  CreateQueueItemPage({Key? key}) : super(key: key);

  final QueueController controller = Get.find<QueueController>();
  final _isProcessing = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To Queue"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/queue_create.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (_isProcessing.value) {
                  return const LoadingWidget();
                }

                return _showSearchWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Column _showSearchWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Course",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SearchCourseWidget(controller: controller),
        const SizedBox(
          height: 12,
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () async {
              _isProcessing.value = true;
              await controller.createQueueItem();
              _isProcessing.value = false;
            },
            child: SizedBox(
              height: 48,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.send_rounded,
                    size: 32.0,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
