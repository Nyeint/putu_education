import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';

class GoButton extends StatelessWidget {
  bool isNext;
  GoButton({super.key,required this.isNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width/4,
      height: context.width/7.5,
      padding: EdgeInsets.only(left: 29, right: 29, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorResources.primary, width: 3),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.white,ColorResources.primary]),
      ),
      child: SvgPicture.asset("assets/icons/${isNext==true?'next':'previous'}.svg"),
    );
  }
}
