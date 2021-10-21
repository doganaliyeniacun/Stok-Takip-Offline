import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton1 extends StatelessWidget {
  CustomElevatedButton1({
    Key? key,
    this.name = "",
    this.function,
    this.color = Colors.blue,
    this.icon,
  }) : super(key: key);

  final String name;
  final Color color;
  final Icon? icon;

  void Function()? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: icon == null ? Text(name.tr) : icon,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
