import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class ReportBottom extends StatelessWidget {
  ReportBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "cashReport".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    "outgoingMoney".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "incomingMoney".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: const Text(
                    "32",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  child: const Text(
                    "0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    "balance".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: AppConstant.blueShade200,
                ),
              ),
              Expanded(
                child: Container(
                  child: const Text(
                    "-32.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: AppConstant.blueShade200,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
