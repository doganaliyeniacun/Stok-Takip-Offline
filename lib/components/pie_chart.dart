import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/report/controller/report_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  PieChart({
    required this.list,
  });

  final ReportController _reportController = Get.put(ReportController());

  final List<DatabaseModel> list;

  final List name = [
    "outgoingMoney".tr,
    "incomingMoney".tr,
  ].obs;

  final List color = [
    Colors.blue,
    Colors.pink,
  ];

  double outgoingMoney() => _reportController.outgoingMoney(list);
  double incomingMoney() => _reportController.incomingMoney(list);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: [
        PieSeries(
          dataSource: name,
          xValueMapper: (datum, index) => name[index],
          yValueMapper: (datum, index) => [
            outgoingMoney(),
            incomingMoney(),
          ][index],
          pointColorMapper: (datum, index) => color[index],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
