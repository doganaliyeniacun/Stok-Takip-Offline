import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class ReportCard extends StatelessWidget {
  late DatabaseModel list;

  ReportCard({
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 4,
          ),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              row1(),
              row2(),
              row3(),
              row4(),
              row5(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded row5() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: const Text(
                "30",
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
                "0",
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
    );
  }

  Expanded row4() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                "outgoingMoney".tr,
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
                "incomingMoney".tr,
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                list.unit.toString(),
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
    );
  }

  Expanded row2() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                "totalStockIn".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                "totalStockOut".tr,
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

  Expanded row1() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            list.stockName.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
