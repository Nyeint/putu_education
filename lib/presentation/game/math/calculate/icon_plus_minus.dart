import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/math/calculate/text_widget.dart';
import 'package:putu_education/presentation/game/math/calculate/what_is.dart';

class IconPlusMinusView extends StatelessWidget {
  final String fruitOne;
  final String fruitTwo;
  final String fruitThree;
  final int a;
  final int b;
  final int c;
  bool? isHistory;
  IconPlusMinusView({super.key, required this.fruitOne, required this.fruitTwo, required this.fruitThree, required this.a, required this.b, required this.c,
  this.isHistory=false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/fruits/$fruitOne.svg",
                    height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3,),
                  TextWidget(text: ' = ', isHistory: isHistory!),
                  TextWidget(text:a.toString(), isHistory: isHistory!),
                ],
              ),
              TextWidget(text:' , ', isHistory: isHistory!),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/fruits/$fruitTwo.svg",
                    height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3),
                  TextWidget(text:' = ', isHistory: isHistory!),
                  TextWidget(text:b.toString(), isHistory: isHistory!),
                ],
              ),
              TextWidget(text:' , ', isHistory: isHistory!),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/fruits/$fruitThree.svg",
                    height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3),
                  TextWidget(text:' = ', isHistory: isHistory!),
                  TextWidget(text:c.toString(), isHistory: isHistory!),
                ],
              ),
            ],
          ).pad(bottom: 20),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/fruits/$fruitOne.svg",
                  height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3),
                TextWidget(text:'+', isHistory: isHistory!),
                SvgPicture.asset("assets/icons/fruits/$fruitTwo.svg",
                  height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3),
                TextWidget(text:'-', isHistory: isHistory!),
                SvgPicture.asset("assets/icons/fruits/$fruitThree.svg",
                  height: isHistory!?context.width*0.08:context.width*0.12, width: isHistory!?context.width*0.26:context.width*0.3),
                TextWidget(text:'=', isHistory: isHistory!),
                WhatIsWidget()
              ],
          ),
        ),
        )
      ],
    );
  }
}
