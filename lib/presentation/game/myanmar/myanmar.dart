// Path: myanmar/myanmar.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';
import 'package:putu_education/presentation/game/widgets/title_item.dart';
import 'package:putu_education/route/my_router.dart';
import '../../widgets/my_appbar.dart';

class MyanmarGameView extends StatefulWidget {
  const MyanmarGameView({super.key});

  @override
  State<MyanmarGameView> createState() => _MyanmarGameViewState();
}

class _MyanmarGameViewState extends State<MyanmarGameView> {
  @override
  Widget build(BuildContext context) {
    final scoreProvider = context.watch<ScoreProvider>();
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: '${tr('myanmar')} ${tr('game')}',
      ),
      body: Container(
        height: context.height,
        width: context.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/game_background.png",),
                fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleItemWidget(
                        title: "${tr('word_sort')}${tr('game')}",
                        iconName: 'mm_word_sort',
                        goTo: RouteName.myanmarWordSortGame,
                        score: scoreProvider.gameHighScore(GameCategory.myanmar,
                            'Word Sorting Game')),
                  ],
                )
                    .pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
              ),
            ),
          ],
        )
      ),
    );
  }
}
