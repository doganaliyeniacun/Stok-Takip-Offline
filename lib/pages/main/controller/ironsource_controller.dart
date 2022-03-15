import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:get/get.dart';

class IronSourceController extends GetxController {
  bool intersitialReady = false;

  @override
  void onInit() async {
    super.onInit();
    var userId = await IronSource.getAdvertiserId();
    await IronSource.validateIntegration();
    await IronSource.setUserId(userId);
    await IronSource.initialize(
      appKey: "13ec33f19",
      gdprConsent: true,
    );
    intersitialReady = await IronSource.isInterstitialReady();
    admobTimer();
  }

  void showInterstitial() async {
    if (await IronSource.isInterstitialReady()) {
      // showHideBanner();
      IronSource.showInterstitial();
    } else {
      print(
        "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it",
      );
    }
  }

  Widget banner() {
    return IronSourceBannerAd(
      keepAlive: true,
      size: BannerSize.BANNER,
      listener: BannerAdListener(),
    );
  }

  void admobTimer() async {
    Timer.periodic(
      const Duration(minutes: 5),
      (timer) {
        IronSource.loadInterstitial();
      },
    );
  }
}

class BannerAdListener extends IronSourceBannerListener {
  @override
  void onBannerAdClicked() {
    print("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    print("onBannerAdLeftApplication");
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    print("onBannerAdLoadFailed");
  }

  @override
  void onBannerAdLoaded() {
    print("onBannerAdLoaded");
  }

  @override
  void onBannerAdScreenDismissed() {
    print("onBannerAdScreenDismisse");
  }

  @override
  void onBannerAdScreenPresented() {
    print("onBannerAdScreenPresented");
  }
}
