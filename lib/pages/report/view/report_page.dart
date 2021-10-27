import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stok_takip_offline/components/pie_chart.dart';

import 'package:stok_takip_offline/components/report_bottom.dart';
import 'package:stok_takip_offline/components/report_card.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/report/controller/report_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with TickerProviderStateMixin {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  final ReportController _reportController = Get.put(ReportController());

  static List<Tab> myTabs = <Tab>[
    Tab(text: 'daily'.tr),
    Tab(text: 'weekly'.tr),
    Tab(text: 'monthly'.tr),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffold,
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TopBanner(color: AppConstant.blueShade200),
          ),
          Expanded(
            flex: 12,
            child: TabBarView(
              controller: _tabController,
              children: [
                dailyView(),
                weeklyView(),
                monthlyView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column monthlyView() {
    return Column(
      children: [
        Expanded(flex: 6, child: PieChart(list: _reportController.listMonth)),
        Expanded(
          flex: 1,
          child: ReportBottom(list: _reportController.listMonth),
        ),
      ],
    );
  }

  Column weeklyView() {
    return Column(
      children: [
        Expanded(flex: 6, child: PieChart(list: _reportController.listWeek)),
        Expanded(
          flex: 1,
          child: ReportBottom(list: _reportController.listWeek),
        ),
      ],
    );
  }

  Column dailyView() {
    return Column(
      children: [
        Expanded(flex: 6, child: PieChart(list: _reportController.listNow)),
        Expanded(
          flex: 1,
          child: ReportBottom(list: _reportController.listNow),
        ),
      ],
    );
  }

  Widget searchBar() {
    return CustomTextFormField1(
        name: "code",
        textInputType: TextInputType.text,
        prefixIcon: Icons.search
        // validator: (value) =>
        //     value == "1" ? "Bilinmeyen Stok Kodu" : null,
        // onSaved: (p0) => print("Kayıt başarılı"),
        );
  }
}
