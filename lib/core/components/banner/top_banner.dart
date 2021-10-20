import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}