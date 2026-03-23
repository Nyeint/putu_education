import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';

import '../../../route/route_name.dart';
import '../../widgets/my_appbar.dart';
import '../widgets/title_item.dart';

class MathGameView extends StatefulWidget {
  const MathGameView({super.key});

  @override
  State<MathGameView> createState() => _MathGameViewState();
}

class _MathGameViewState extends State<MathGameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/game_background.png",),
                    fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                MyAppBar(
                  titleWithGoBack: '${tr('math')} ${tr('game')}',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleItemWidget(title: "${tr('counting')} ${tr('game')}",iconName: 'math_count', goTo: RouteName.mathCountingGame, score: 30),
                        SizedBox(height: 24,),
                        TitleItemWidget(title: "${tr('calculating')} ${tr('game')}",iconName: 'math_calculate', goTo: RouteName.mathCalculateGame, score: 20),
                      ],
                    )
                        .pad(left: 16, right: 16, top: 24, bottom: 24),
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}
