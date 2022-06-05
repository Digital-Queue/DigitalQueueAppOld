import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
