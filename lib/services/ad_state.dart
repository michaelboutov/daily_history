import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  BannerAd ad;

  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-5522166655169957/1947757289'
      : 'ca-app-pub-5522166655169957/3358913431';

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) => print("ad loaded"),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened'),
        onAdClosed: (Ad ad) => print('Ad closed'),
      ),
    );
    return ad;
  }

  static String get interstitialAdId => Platform.isAndroid
      ? 'ca-app-pub-5522166655169957/4988772413'
      : 'ca-app-pub-5522166655169957/9474812336';

  static InterstitialAd interstitialAd;

  static loadInterstitial() async {
    interstitialAd = InterstitialAd(
      adUnitId: interstitialAdId,
      request: AdRequest(),
      listener: AdListener(onAdLoaded: (Ad ad) {
        interstitialAd.show();
      }, onAdClosed: (Ad ad) {
        interstitialAd.dispose();
      }),
    );

    interstitialAd.load();
  }
}
