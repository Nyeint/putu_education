// Path: english/sentence_sort_game.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';
import 'package:putu_education/presentation/game/english/sentence_sort_game_controller.dart';
import 'package:putu_education/presentation/game/english/sort_result.dart';
import '../../../route/route_name.dart';
import '../../widgets/item_decoration.dart';
import '../../widgets/my_appbar.dart';
import '../widgets/front_flip_card_item.dart';
import '../widgets/progress_bar.dart';
import '../widgets/success_feedback_view.dart';
import '../widgets/voice_item.dart';
import '../widgets/word_tile_view.dart';

class EnglishSentenceSortGame extends StatefulWidget {
  const EnglishSentenceSortGame({super.key});

  @override
  State<EnglishSentenceSortGame> createState() => _EnglishSentenceSortGameState();
}

class _EnglishSentenceSortGameState extends State<EnglishSentenceSortGame> {
  late final SentenceSortGameController _controller;
  bool _hasNavigatedToResult = false;

  @override
  void initState() {
    super.initState();
    _controller = SentenceSortGameController()..loadQuestions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToResult(SentenceSortGameController controller) {
    if (_hasNavigatedToResult) return;
    _hasNavigatedToResult = true;

    context.read<ScoreProvider>().recordScore(
          category: GameCategory.english,
          gameTitle: 'Sentence Sorting Game',
          score: controller.correctCount,
        );
    context.replaceNamed(
      RouteName.resultView,
      extra: {
        'score': controller.correctCount,
        'childWidget': SortResultView(historyList: List.of(controller.historyList)),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        backgroundColor: Color(0xff7AEEFC),
        appBar: MyAppBar(titleWithGoBack: '${tr('sentence_sort')} ${tr('game')}'),
        body: SafeArea(
          bottom: false,
          child: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/game_background.png"), fit: BoxFit.cover),
            ),
            child: Consumer<SentenceSortGameController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator(color: ColorResources.primary));
                }

                if (controller.isCompleted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _goToResult(controller));
                  return const SizedBox.shrink();
                }

                final question = controller.currentQuestion;

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ProgressBarView(
                            currentStep: controller.currentIndex + 1,
                            totalSteps: controller.questions.length,
                          ),
                          SizedBox(height: 24),
                          VoiceItemView(
                            name: question.sentence,
                            description: 'Listen and arrange',
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: context.width * 0.45,
                            height: context.width * 0.45,
                            child: FrontFlipCardItem(image: question.imageUrl, isSelected: true),
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...controller.selectedWords.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => controller.deselectWord(entry.key),
                                  child: Text(
                                    entry.value,
                                    style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                                  ),
                                );
                              }),
                              ...List.generate(
                                question.words.length - controller.selectedWords.length,
                                (index) => Text(
                                  '_',
                                  style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: controller.scrambledWords.asMap().entries.map((entry) {
                              return WordTileView(
                                word: entry.value,
                                onTap: controller.isChecking ? null : () => controller.selectWord(entry.key),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 90),
                        ],
                      ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 40 + MediaQuery.of(context).padding.bottom,
                      child: GestureDetector(
                        onTap: controller.isAnswerFilled ? controller.manualAdvance : null,
                        child: Container(
                          padding: EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
                          decoration: controller.isAnswerFilled ? selectedDecoration() : unselectedDecoration(),
                          child: controller.currentIndex == controller.questions.length - 1
                              ? Text(tr('check'), style: FontFamily().medium)
                              : SvgPicture.asset("assets/icons/next.svg"),
                        ),
                      ),
                    ),
                    // Positioned.fill(
                    //   child: Center(child: SuccessFeedbackView(visible: controller.isChecking)),
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
