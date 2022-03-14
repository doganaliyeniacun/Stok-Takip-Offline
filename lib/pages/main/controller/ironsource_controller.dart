// import 'package:flutter/material.dart';
// import 'package:flutter_ironsource_x/ironsource.dart';
// import 'package:get/get.dart';

// class IronSourceController extends GetxController {
//   @override
//   void onInit() async {
//     super.onInit();
//     var userId = await IronSource.getAdvertiserId();
//     await IronSource.validateIntegration();
//     await IronSource.setUserId(userId);
//     await IronSource.initialize(
//       appKey: "13ec33f19",
//       gdprConsent: true,
//       ccpaConsent: false,
//     );
//   }

//   void showInterstitial() async {
//     if (await IronSource.isInterstitialReady()) {
//       IronSource.showInterstitial();
//     } else {
//       print(
//         "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
//       );
//     }
//   }

//   Widget banner() {
//     return const IronSourceBannerAd(keepAlive: true);
//   }
// }
