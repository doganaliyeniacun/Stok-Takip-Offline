import 'dart:async';

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
        adUnitId: "ca-app-pub-5702028324956530/6098823776",
        listener: BannerAdListener(onAdLoaded: (_) {
          isLoaded.value = true;
        }, onAdFailedToLoad: (_, error) {
          print("Ad Failed to Load with Error= $error");
        }),
        request: const AdRequest());
    _ad.load();
    admobTimer();
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

  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-5702028324956530/3217509561",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  bool checkTime = false;

  void checkInterstitial() {
    if (checkTime == true) {
      _loadInterstitialAd();
      if (_isInterstitialAdReady) {
        _interstitialAd!.show();
        _isInterstitialAdReady = false;
      }

      checkTime = false;
    }
  }

  void admobTimer() {
    Timer.periodic(
      const Duration(minutes: 5),
      (timer) {
        checkTime = true;
      },
    );
  }

  // int limit = 0;
  // void checkInterstitial() {
  //   limit = limit + 1;
  //   print(limit);
  //   if (limit >= 3) {
  //     _loadInterstitialAd();
  //     if (_isInterstitialAdReady) {
  //       _interstitialAd!.show();
  //       _isInterstitialAdReady = false;
  //     }

  //     limit = 0;
  //   }
  // }
}
