import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/report/controller/report_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class ReportBottom extends StatelessWidget {
  final ReportController _reportController = Get.put(ReportController());
  final RxList<DatabaseModel> list;

  ReportBottom({required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        row1(),
        row2(),
        row3(),
        row4(),
      ],
    );
  }

  Expanded row2() {
    return Expanded(
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
    );
  }

  Expanded row4() {
    return Expanded(
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
              child: Text(
                _reportController.balance(list).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: AppConstant.blueShade200,
            ),
          ),
        ],
      ),
    );
  }

  Expanded row3() {
    return Expanded(
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  _reportController.outgoingMoney(list).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  _reportController.incomingMoney(list).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
    );
  }

  Expanded row1() {
    return Expanded(
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
    );
  }
}
