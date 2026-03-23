import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/game/widgets/title_item.dart';
import 'package:putu_education/route/my_router.dart';
import '../../widgets/my_appbar.dart';

class EnglishGameView extends StatefulWidget {
  const EnglishGameView({super.key});

  @override
  State<EnglishGameView> createState() => _EnglishGameViewState();
}

class _EnglishGameViewState extends State<EnglishGameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: '${tr('english')} ${tr('game')}',
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
            // MyAppBar(
            //   titleWithGoBack: '${tr('english')} ${tr('game')}',
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleItemWidget(title: "${tr('word')}${tr('game')}",iconName: 'english_word', goTo: RouteName.englishWordGame, score: 30),
                    SizedBox(height: 10,),
                    TitleItemWidget(title: "${tr('word_sort')}${tr('game')}",iconName: 'english_word_sort', goTo: RouteName.englishWordSortGame, score: 20),
                    SizedBox(height: 10,),
                    TitleItemWidget(title: "${tr('sentence_sort')}${tr('game')}",iconName: 'english_sentence', goTo: RouteName.englishSentenceSortGame, score: 15),
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
