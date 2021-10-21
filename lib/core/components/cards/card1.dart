import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMenuCard1 extends StatelessWidget {
  const CustomMenuCard1({
    Key? key,
    required this.name,
    this.function,
    this.color = Colors.blue,
  }) : super(key: key);

  final String name;
  final Color color;
  
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        elevation: 20,
        child: Container(
          height: Get.height * 0.15,
          width: Get.width,
          decoration: BoxDecoration(
            color: color,
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
