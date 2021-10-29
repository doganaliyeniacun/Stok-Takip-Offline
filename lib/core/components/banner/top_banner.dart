import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBanner extends StatelessWidget {
  TopBanner({
    Key? key,
    this.color = Colors.blue,
    this.widget,
  }) : super(key: key);

  final Color color;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      child: Container(
        // height: Get.height * 0.10,
        width: Get.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        child: widget,
      ),
    );
  }
}
