// Path: topics/presentation/pages/games/en_word_game.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';
import 'package:putu_education/features/topics/presentation/pages/results/word_result.dart';
import 'package:putu_education/features/game/model/question_result.dart';
import 'package:putu_education/features/game/widgets/front_flip_card_item.dart';
import 'package:putu_education/features/game/widgets/progress_bar.dart';
import 'package:putu_education/features/widgets/item_decoration.dart';
import 'package:putu_education/features/widgets/my_appbar.dart';
import 'package:putu_education/route/route_name.dart';
import '../../../../game/widgets/audio_prompt_view.dart';
import '../../../data/model/game_model.dart';
import '../../bloc/game_bloc/game_bloc.dart';

/// Choose-the-picture game: fetches a set of prompts (each with a list of
/// picture options) from `GET games/choose-picture?subject=en|my` and lets
/// the player pick the option that matches the prompt. Picking an option
/// with `isCorrect: true` scores 1 point.
///
/// [subject] selects both the API language and which of a question's
/// bilingual fields are shown/played: 'en' uses `prompt`/`audio`; anything
/// else (the API's 'my') uses `prompt_mm`/`audio_mm`.
class EnglishWordGame extends StatefulWidget {
  final String subject;

  const EnglishWordGame({super.key, this.subject = 'en'});

  @override
  State<EnglishWordGame> createState() => _EnglishWordGameState();
}

class _EnglishWordGameState extends State<EnglishWordGame> {
  final GameBloc _gameBloc = getIt<GameBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  int currentStep = 0;
  int selectedIndex = -1;
  int correctCount = 0;
  bool _hasNavigatedToResult = false;
  List<QuestionResultModel> historyList = [];

  bool get _isEnglish => widget.subject == 'en';

  @override
  void initState() {
    super.initState();
    _gameBloc.add(ChoosePictureGameRequested(subject: widget.subject));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _gameBloc.close();
    super.dispose();
  }

  String _prompt(GameData question) => (_isEnglish ? question.prompt : question.promptMm) ?? '';

  String _audioUrl(GameData question) =>
      question.options?.firstWhere((o) => o.isCorrect == true, orElse: () => Options()).audioUrl ?? '';

  /// Plays the question's pre-recorded prompt audio (no TTS involved).
  Future<void> _playAudio(GameData question) async {
    await Future.delayed(Duration(milliseconds: 500));
    print("Question--> ${question.toJson()}");
    print('One--> ${question.options![0].toJson()}');
    print('Two--> ${question.options![1].toJson()}');
    print('Three--> ${question.options![2].toJson()}');
    print('Four--> ${question.options![3].toJson()}');
    final url = _audioUrl(question);
    print("Url--> $url");
    if (url.isEmpty) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (_) {
      // Swallow playback failures - audio is a supplementary hint, not a
      // blocker for playing the game.
    }
  }

  void _goToNext(List<GameData> questions) {
    if (selectedIndex == -1) return;

    final question = questions[currentStep];
    final selectedOption = question.options![selectedIndex];
    final isCorrect = selectedOption.isCorrect ?? false;
    if (isCorrect) correctCount++;

    historyList.add(QuestionResultModel(
      question: _prompt(question),
      result: selectedOption.imageUrl ?? selectedOption.image ?? '',
    ));

    if (currentStep == questions.length - 1) {
      _goToResult(questions.length);
      return;
    }

    setState(() {
      currentStep++;
      selectedIndex = -1;
    });
    _playAudio(questions[currentStep]);
  }

  void _goToResult(int totalSteps) {
    if (_hasNavigatedToResult) return;
    _hasNavigatedToResult = true;

    context.read<ScoreProvider>().recordScore(
        category: _isEnglish ? GameCategory.english : GameCategory.myanmar,
        gameTitle: _isEnglish ? 'Word Game' : 'စကားလုံးဂိမ်း', score: correctCount);
    context.replaceNamed(RouteName.resultView,
      extra: {'score': correctCount, 'maxScore': totalSteps, 'childWidget': WordResultView(historyList: historyList)},);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(
        titleWithGoBack: _isEnglish ? '${tr('word')} ${tr('game')}' : 'စကားလုံးရှာမယ်',
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
          child: BlocListener<GameBloc, GameState>(
            bloc: _gameBloc,
            // Auto-play the prompt audio only right as questions first load,
            // not on every rebuild - subsequent questions are played from
            // _goToNext instead.
            listenWhen: (previous, current) =>
                previous.choosePictureStatus != GameLoadStatus.success &&
                current.choosePictureStatus == GameLoadStatus.success,
            listener: (context, state) {
              if (state.choosePictureQuestions.isNotEmpty) _playAudio(state.choosePictureQuestions.first);
            },
            child: BlocBuilder<GameBloc, GameState>(
              bloc: _gameBloc,
              builder: (context, state) {
                if (state.choosePictureStatus == GameLoadStatus.loading ||
                    state.choosePictureStatus == GameLoadStatus.initial) {
                  return Center(child: CircularProgressIndicator(color: ColorResources.primary));
                }

                if (state.choosePictureStatus == GameLoadStatus.failure) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => _gameBloc.add(ChoosePictureGameRequested(subject: widget.subject)),
                      child: Text(
                        'Failed to load. Tap to retry.',
                        style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen),
                      ),
                    ),
                  );
                }

                final questions = state.choosePictureQuestions;
                if (questions.isEmpty) {
                  return Center(
                    child: Text(tr('no_data'), style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen)),
                  );
                }

                final question = questions[currentStep];
                final options = question.options ?? [];

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ProgressBarView(currentStep: currentStep + 1, totalSteps: questions.length),
                          SizedBox(height: 24,),
                          AudioPromptView(
                            description: _prompt(question),
                            onPlayAudio: () => _playAudio(question),
                          ),
                          SizedBox(height: 24,),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorResources.primary, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: ColorResources.lightBg.withOpacity(0.5)
                            ),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 15, mainAxisSpacing: 15,
                                    crossAxisCount: 2
                                ),
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => setState(() => selectedIndex = index),
                                      child: FrontFlipCardItem(
                                        image: options[index].imageUrl ?? options[index].image ?? '',
                                        isSelected: selectedIndex == index,
                                      )
                                  );
                                }
                            ),
                          ),
                          SizedBox(height: 90,),
                        ],
                      ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 80 + MediaQuery.of(context).padding.bottom,
                      child: GestureDetector(
                        onTap: () {
                          if(selectedIndex!=-1){
                            _audioPlayer.play(AssetSource('audios/pop.mp3'));
                            _goToNext(questions);
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 22, right: 22,top: 8, bottom: 8),
                            decoration: selectedIndex == -1 ? unselectedDecoration() : selectedTabDecoration(),
                            child: currentStep == questions.length - 1 ? Text(tr('check')):
                            SvgPicture.asset("assets/icons/next.svg")
                        ),
                      ),
                    ),
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
