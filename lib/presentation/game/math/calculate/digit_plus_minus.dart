import 'package:flutter/material.dart';
import 'package:putu_education/presentation/game/math/calculate/text_widget.dart';
import 'package:putu_education/presentation/game/math/calculate/what_is.dart';

import '../calculate_game.dart';

class DigitPlusMinusView extends StatelessWidget {
  final int a;
  final int b;
  final int c;
  final int result;
  final CalculateType type;
  final bool? isHistory;
  const DigitPlusMinusView({super.key, required this.a, required this.b, required this.c, required this.result, required this.type,
  this.isHistory=false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        type==CalculateType.type1?
        TextWidget(text: a.toString(), isHistory: isHistory!,):WhatIsWidget(),
        TextWidget(text: '+'),
        TextWidget(text: b.toString(), isHistory: isHistory!),
        TextWidget(text: '-'),
        TextWidget(text: c.toString(), isHistory: isHistory!),
        TextWidget(text: '='),
        type==CalculateType.type1?WhatIsWidget():
        TextWidget(text: result.toString(), isHistory: isHistory!),
      ],
    );
  }
}
