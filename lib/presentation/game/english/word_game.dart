// Path: english/word_game.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';
import 'package:putu_education/presentation/game/english/word_result.dart';
import 'package:putu_education/presentation/game/widgets/front_flip_card_item.dart';
import 'package:putu_education/presentation/game/widgets/progress_bar.dart';
import 'package:putu_education/presentation/game/widgets/voice_item.dart';
import '../../../route/route_name.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/item_voice_dialog.dart';
import '../../widgets/my_appbar.dart';
import '../model/question_result.dart';
import '../model/word_item.dart';

class EnglishWordGame extends StatefulWidget {
  const EnglishWordGame({super.key});

  @override
  State<EnglishWordGame> createState() => _EnglishWordGameState();
}

class _EnglishWordGameState extends State<EnglishWordGame> {
  final FlutterTts flutterTts = FlutterTts();

  int currentStep = 0;
  int totalSteps = 10;
  int selectedIndex = -1;
  int correctCount = 0;
  List<QuestionResultModel> historyList = [];

  late List<WordItem> sessionQuestions;
  late List<WordItem> currentOptions;

  WordItem get currentQuestion => sessionQuestions[currentStep];

  @override
  void initState() {
    super.initState();
    sessionQuestions = (List<WordItem>.from(wordGameMasterList)..shuffle())
        .take(totalSteps)
        .toList();
    generateOptions();
    speakWord(currentQuestion.word);
  }

  // Picks the current question plus 3 other random, non-repeating items from
  // the master list, then shuffles so the correct answer isn't always first.
  void generateOptions() {
    final wrongAnswers = wordGameMasterList
        .where((item) => item.id != currentQuestion.id)
        .toList()
      ..shuffle();
    currentOptions = [currentQuestion, ...wrongAnswers.take(3)]..shuffle();
  }

  setHistoryList({required String result, required String question}) {
    QuestionResultModel model = QuestionResultModel(
        result: result,
        question: question
    );
    historyList.add(model);
  }

  speakWord(String word) async {
    await flutterTts.speak(word);
  }

  void goToNext() {
    if (selectedIndex == -1) return;

    final selectedItem = currentOptions[selectedIndex];
    final isCorrect = selectedItem.id == currentQuestion.id;
    if (isCorrect) correctCount++;

    setHistoryList(result: selectedItem.imageUrl, question: currentQuestion.word);

    if (currentStep == totalSteps - 1) {
      // Dashboard high scores are tracked on a 0-100 scale across all english
      // games, but the result screen shows the raw x/totalSteps fraction.
      // final percentageScore = ((correctCount / totalSteps) * 100).round();
      context.read<ScoreProvider>().recordScore(
          category: GameCategory.english, gameTitle: 'Word Game', score: correctCount);
      context.replaceNamed(RouteName.resultView,
        extra: {'score': correctCount, 'maxScore': totalSteps, 'childWidget': WordResultView(historyList: historyList,)},);
      return;
    }

    setState(() {
      currentStep++;
      selectedIndex = -1;
      generateOptions();
    });
    speakWord(currentQuestion.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: '${tr('word')} ${tr('game')}',
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/game_background.png",),
                  fit: BoxFit.fill)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProgressBarView(currentStep: currentStep + 1, totalSteps: totalSteps),
                SizedBox(height: 24,),
                VoiceItemView(name: currentQuestion.word, description: "Listen and pick",),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorResources.primary, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ColorResources.lightBg.withOpacity(0.5)
                  ),
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisSpacing: 15, mainAxisSpacing: 15,
                          crossAxisCount: 2
                      ),
                      itemCount: currentOptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              selectedIndex=index;
                              setState(() {});
                            },
                            child:
                            FrontFlipCardItem(image: currentOptions[index].imageUrl,isSelected: selectedIndex==index,)
                        );
                      }
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: goToNext,
                    child: Container(
                        padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                        decoration: selectedTabDecoration(),
                        child: currentStep==totalSteps-1?Text(tr('check')):
                        SvgPicture.asset("assets/icons/next.svg")
                    ),
                  ),
                ),
              ],
            ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
          ),
        ),
      ),
    );
  }
}
