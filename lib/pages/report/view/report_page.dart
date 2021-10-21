import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:stok_takip_offline/components/report_bottom.dart';
import 'package:stok_takip_offline/components/report_card.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

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
            child: reportView(),
          ),
        ],
      ),
    );
  }

  TabBarView reportView() {
    return TabBarView(
      controller: _tabController,
      children: myTabs.map((Tab tab) {
        final String label = tab.text!.toLowerCase();
        return Column(
          children: [
            Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => ReportCard(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ReportBottom(),
            ),
          ],
        );
      }).toList(),
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
