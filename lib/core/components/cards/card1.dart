import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMenuCard1 extends StatelessWidget {
  const CustomMenuCard1({
    Key? key,
    required this.name,
    this.function,
  }) : super(key: key);

  final String name;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.blue.shade200,
        elevation: 20,
        child: Container(
          height: Get.height * 0.15,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              name.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
