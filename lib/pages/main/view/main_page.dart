import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/Cards/card1.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/utils/const/const.dart';
import 'package:stok_takip_offline/utils/internationalization/translations.dart';

import '../controller/ironsource_controller.dart';

class MainPage extends GetView<InitTranslations> {
  // final MainController _mainController = Get.put(MainController());
  final IronSourceController _ironSourceController =
      Get.put(IronSourceController());

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
          // Expanded(
          //   flex: 1,
          //   child: Obx(
          //     () => TopBanner(
          //       color: AppConstant.blueShade200,
          //       widget: _mainController.checkForAd(),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: TopBanner(
              color: AppConstant.blueShade200,
              widget: _ironSourceController.banner(),
            ),
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
        crossAxisCount: 3,
      ),
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        CustomMenuCard1(
          name: "menu1",
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu1");
          },
          color: AppConstant.blueShade200,
        ),
        CustomMenuCard1(
          name: "menu2",
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu2");
          },
          color: AppConstant.blueShade200,
        ),
        CustomMenuCard1(
          name: "menu3",
          color: AppConstant.blueShade200,
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu3");
          },
        ),
        CustomMenuCard1(
          name: "menu4",
          color: AppConstant.blueShade200,
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu4");
          },
        ),
        CustomMenuCard1(
          name: "menu5",
          color: AppConstant.blueShade200,
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu5");
          },
        ),
        CustomMenuCard1(
          name: "menu6",
          color: AppConstant.blueShade200,
          function: () {
            _ironSourceController.showInterstitial();
            Get.toNamed("/menu6");
          },
        ),
      ],
    );
  }
}
