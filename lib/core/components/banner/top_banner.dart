import 'package:flutter/material.dart';

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
