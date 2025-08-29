import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/math/calculate/text_widget.dart';
import 'package:putu_education/presentation/game/math/calculate/what_is.dart';
import 'package:putu_education/presentation/game/math/calculate_game.dart';

class IconsMultiplyDivide extends StatelessWidget {
  final String fruitOne;
  final String fruitTwo;
  final int a;
  final int b;
  final CalculateType type;
  bool? isHistory;
  IconsMultiplyDivide({super.key, required this.fruitOne, required this.fruitTwo, required this.a, required this.b, required this.type,
  this.isHistory=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type==CalculateType.type3||type==CalculateType.type4?
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/fruits/$fruitOne.svg",
                    height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3,),
                  TextWidget(text:' = '),
                  TextWidget(text:a.toString()),
                ],
              ),
              TextWidget(text:' , '),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/fruits/$fruitTwo.svg",
                    height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3,),
                  TextWidget(text:' = '),
                  TextWidget(text:b.toString()),
                ],
              )
            ],
          ).pad(bottom: 20),
        ):SizedBox(height: 0, width: 0,),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                type==CalculateType.type3||type==CalculateType.type4?
                SvgPicture.asset("assets/icons/fruits/$fruitOne.svg",
                  height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3,):
                TextWidget(text:a.toString()),
                TextWidget(text:type==CalculateType.type3||type==CalculateType.type5?' * ':' % '),

                type==CalculateType.type3||type==CalculateType.type4?
                SvgPicture.asset("assets/icons/fruits/$fruitTwo.svg",
                  height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3,):
                TextWidget(text:b.toString()),
                TextWidget(text:' = '),
                WhatIsWidget()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
