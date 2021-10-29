import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainController extends GetxController {
  late BannerAd _ad;
  late RxBool isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();

    _ad = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-8138129845044197/1147227496",
        listener: BannerAdListener(onAdLoaded: (_) {
          isLoaded.value = true;
        }, onAdFailedToLoad: (_, error) {
          print("Ad Failed to Load with Error= $error");
        }),
        request: AdRequest());
    _ad.load();
  }

  Widget checkForAd() {
    if (isLoaded.value == true) {
      return Container(
        child: AdWidget(
          ad: _ad,
        ),
        width: _ad.size.width.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return const Text("");
    }
  }
}
