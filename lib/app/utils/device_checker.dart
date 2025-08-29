import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

enum DeviceType {
  Mobile,
  Tablet,
}

class DeviceChecker {
  static BuildContext? _context;

  static void initialize(BuildContext context) {
    _context = context;
  }

  static Future<DeviceType> getDeviceType1() async {
    if (_context == null) {
      throw Exception('DeviceChecker must be initialized with a valid BuildContext');
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(_context!).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      double diagonalInches = _getScreenSizeInInches(androidInfo);
      return _classifyDevice(diagonalInches);
    } else if (Theme.of(_context!).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      double diagonalInches = _getScreenSizeInInches(iosInfo);
      return _classifyDevice(diagonalInches);
    }
    return DeviceType.Mobile; // Default to mobile for other platforms
  }

  static double _getScreenSizeInInches(dynamic deviceInfo) {
    double screenWidth = deviceInfo.screenWidth;
    double screenHeight = deviceInfo.screenHeight;
    double diagonalInches = sqrt(pow(screenWidth, 2) + pow(screenHeight, 2)) / 25.4; // Convert to inches
    return diagonalInches;
  }

  static DeviceType _classifyDevice(double diagonalInches) {
    if (diagonalInches >= 7.0) {
      return DeviceType.Tablet;
    } else {
      return DeviceType.Mobile;
    }
  }
}