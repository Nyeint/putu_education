import 'package:flutter/cupertino.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension SysPaddingEx on Widget {
  Widget pad(
      {double top = 0,
        double right = 0,
        double left = 0,
        double bottom = 0}) =>
      Padding(
        padding:
        EdgeInsets.only(top: top, right: right, left: left, bottom: bottom),
        child: this,
      );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}


extension NumeralConverter on String {
  static const Map<String, String> numeralMap = {
    '0': '၀',
    '1': '၁',
    '2': '၂',
    '3': '၃',
    '4': '၄',
    '5': '၅',
    '6': '၆',
    '7': '၇',
    '8': '၈',
    '9': '၉'
  };
  String burmese() {
    String burmeseNumber = this.split('').map((char) {
      return numeralMap[char] ?? char;
    }).join('');
    return burmeseNumber;
  }
}