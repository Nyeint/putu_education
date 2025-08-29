import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

class TextWidget extends StatelessWidget {
  String text;
  bool isHistory;
  TextWidget({super.key, required this.text, this.isHistory=false});

  @override
  Widget build(BuildContext context) {
    return  Text(context.locale.languageCode == 'en'?text:text.burmese(),style: FontFamily().medium.copyWith(fontSize: isHistory?FontSize().eighteen:FontSize().twenty));
  }
}
