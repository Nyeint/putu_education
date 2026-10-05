// Path: utils/ad_helper.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class AdHelper {
  // Debug builds always use Google's official test IDs.
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'TODO_ANDROID_BANNER_AD_UNIT_ID'; // TODO: real Android banner ID
    } else if (Platform.isIOS) {
      return kDebugMode
          ? 'ca-app-pub-3940256099942544/2934735716'
          : 'TODO_IOS_BANNER_AD_UNIT_ID'; // TODO: real iOS banner ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3798524896394295/5581145533';
    } else if (Platform.isIOS) {
      return 'in ad';
      // return 'ca-app-pub-3940256099942544/4411468910';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'Constants.iosRewardAd';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
