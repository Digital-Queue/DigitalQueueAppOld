import 'package:digital_queue/queues/models/queue_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QueueItemWidget extends StatelessWidget {
  const QueueItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final QueueItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.me ? Colors.green.shade50 : Colors.white,
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
                item.me ? "You" : item.student!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
