import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/Cards/card1.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/pages/database_page/controller/database_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class DatabasePage extends StatelessWidget {
  final DatabaseController _databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: myBody(),
      ),
    );
  }

  Container myBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TopBanner(color: AppConstant.blueShade200),
          ),
          const Expanded(
            flex: 6,
            child: CenterImage(),
          ),
          Expanded(
            flex: 6,
            child: menuItems(),
          ),
        ],
      ),
    );
  }

  GridView menuItems() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        CustomMenuCard1(
          name: "Rapor ve Listeyi\nExcele Aktar",
          color: AppConstant.blueShade200,
          function: () => _databaseController.getStoragePermission(),
        ),
        CustomMenuCard1(
          name: "Veritabanını\nYedekle ve Paylaş",
          color: AppConstant.blueShade200,
          function: ()=> _databaseController.docBackUpAndShare(),
        ),      
      ],
    );
  }
}
