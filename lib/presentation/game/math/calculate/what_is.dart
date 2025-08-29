import 'package:flutter/cupertino.dart';

import '../../../../app/config/config.dart';
import '../../../widgets/item_decoration.dart';

class WhatIsWidget extends StatelessWidget {
  const WhatIsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      alignment: Alignment.center,
      decoration: unselectedTabDecoration(),
      child: Text(
        '?',
        style: FontFamily().medium.copyWith(fontSize: FontSize().twentyFour),
      ),
    );
  }
}
