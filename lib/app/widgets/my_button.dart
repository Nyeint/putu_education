import 'package:flutter/material.dart';

import '../config/color_resources.dart';
import '../config/font_family.dart';

class MyButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  double width;
  MyButton({super.key, required this.text, required this.onTap, this.width=0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: ColorResources.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child:
          Text(
            text,
            style: FontFamily().regular.copyWith(color: Colors.white),
          )),
    );
  }
}
