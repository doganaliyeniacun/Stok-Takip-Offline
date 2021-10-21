import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBanner extends StatelessWidget {
  TopBanner({
    Key? key,
    this.color = Colors.blue,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      child: Container(
        // height: Get.height * 0.10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
