// Path: calculate/digit_plus_minus.dart
import 'package:flutter/material.dart';
import 'package:putu_education/features/game/math/calculate/text_widget.dart';
import 'package:putu_education/features/game/math/calculate/what_is.dart';

import '../../../topics/presentation/pages/games/calculate_game.dart';

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
      crossAxisAlignment: WrapCrossAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextWidget(text: a.toString(), isHistory: isHistory!,),
        TextWidget(text: '+'),
        TextWidget(text: b.toString(), isHistory: isHistory!),
        TextWidget(text: '-'),
        TextWidget(text: c.toString(), isHistory: isHistory!),
        TextWidget(text: '='),
        WhatIsWidget(answer: isHistory! ? result.toString() : null),
      ],
    );
  }
}
