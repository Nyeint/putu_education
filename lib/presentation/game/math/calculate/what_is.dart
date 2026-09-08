// Path: calculate/what_is.dart
import 'package:flutter/cupertino.dart';

import '../../../../app/config/config.dart';
import '../../../widgets/item_decoration.dart';

class WhatIsWidget extends StatelessWidget {
  const WhatIsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width * 0.1,
      // height: MediaQuery.of(context).size.width * 0.1,
      // padding: EdgeInsets.all(10),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorResources.stroke, width: 2),
          shape: BoxShape.circle),
      // decoration: unselectedTabDecoration(),
      child: Text(
        '?',
        style: FontFamily().medium.copyWith(fontSize: FontSize().twenty),
      ),
    );
  }
}
