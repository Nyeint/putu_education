// Path: topics/presentation/pages/games/mm_word_sort_game.dart
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/data/model/game_category.dart';
import 'package:putu_education/data/providers/score_provider.dart';
import 'package:putu_education/features/topics/presentation/pages/results/sort_result.dart';
import 'package:putu_education/features/game/model/question_result.dart';
import 'package:putu_education/features/game/widgets/audio_prompt_view.dart';
import 'package:putu_education/features/game/widgets/choose_questions_alert.dart';
import 'package:putu_education/features/game/widgets/front_flip_card_item.dart';
import 'package:putu_education/features/game/widgets/letter_tile_view.dart';
import 'package:putu_education/features/game/widgets/progress_bar.dart';
import 'package:putu_education/features/game/widgets/success_feedback_view.dart';
import 'package:putu_education/features/widgets/item_decoration.dart';
import 'package:putu_education/features/widgets/my_appbar.dart';
import 'package:putu_education/route/route_name.dart';
import '../../../data/model/game_model.dart';
import '../../../domain/repositories/game_repo.dart';
import '../../bloc/game_bloc/game_bloc.dart';

/// Word Sorting game: fetches a set of words from
/// `GET games/word-sorting?subject=en|my` and has the player arrange
/// scrambled letters back into each word (`lesson.word`, uppercased).
/// Arranging a word correctly scores 1 point.
///
/// [subject] selects both the API language and which of a question's
/// bilingual audio fields is played: 'en' uses `audio`; anything else (the
/// API's 'my') uses `audio_mm`.
class EnglishWordSortGame extends StatefulWidget {
  final String subject;

  const EnglishWordSortGame({super.key, this.subject = 'en'});

  @override
  State<EnglishWordSortGame> createState() => _EnglishWordSortGameState();
}

class _EnglishWordSortGameState extends State<EnglishWordSortGame> {
  final GameBloc _gameBloc = getIt<GameBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();

  static const Duration _successDelay = Duration(seconds: 1);

  int currentStep = 0;
  List<String> selectedLetters = [];
  List<String> scrambledLetters = [];

  /// True while an answer is fully filled in and being validated/animated -
  /// letter taps are ignored during this window so the board can't change
  /// mid-feedback.
  bool isChecking = false;

  int correctCount = 0;
  bool _hasNavigatedToResult = false;
  final List<QuestionResultModel> historyList = [];

  bool get _isEnglish => widget.subject == 'en';

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final hasCache = await getIt<GameRepo>().hasWordSortingCache(subject: widget.subject);
    final forceRefresh = hasCache && mounted ? await showChooseQuestionsAlert(context) : false;
    if (!mounted) return;
    _gameBloc.add(WordSortingGameRequested(subject: widget.subject, forceRefresh: forceRefresh));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _gameBloc.close();
    super.dispose();
  }

  String _wordFor(GameData question) => (question.lesson?.word ?? question.targetText ?? '').toUpperCase();

  String _imageFor(GameData question) => question.lesson?.imageUrl ?? question.image ?? '';

  String _audioUrl(GameData question) => question.lesson!.audio ?? '';

  /// Plays the question's pre-recorded audio (no TTS involved).
  Future<void> _playAudio(GameData question) async {
    await Future.delayed(Duration(milliseconds: 500));
    final url = _audioUrl(question);
    if (url.isEmpty) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (_) {
      // Swallow playback failures - audio is a supplementary hint, not a
      // blocker for playing the game.
    }
  }

  /// One tile per code point for both languages, so Myanmar marks are
  /// separate tiles (ပန်းသီး -> ပ န ် း သ ီ း).
  List<String> _lettersOf(String word) => word.runes.map(String.fromCharCode).toList();

  List<String> _shuffledLettersOf(String word) {
    final letters = _lettersOf(word);
    if (letters.length <= 1) return letters;

    List<String> shuffled;
    do {
      shuffled = List<String>.from(letters)..shuffle(_random);
    } while (shuffled.join() == word);
    return shuffled;
  }

  void _startQuestion(GameData question) {
    setState(() {
      scrambledLetters = _shuffledLettersOf(_wordFor(question));
      selectedLetters = [];
      isChecking = false;
    });
  }

  /// Moves the scrambled letter at [poolIndex] into the answer blanks.
  void _selectLetter(int poolIndex) {
    if (isChecking) return;
    setState(() {
      final letter = scrambledLetters.removeAt(poolIndex);
      selectedLetters.add(letter);
    });
  }

  /// Returns the filled letter at [selectedIndex] back to the letter pool.
  void _deselectLetter(int selectedIndex) {
    if (isChecking) return;
    setState(() {
      final letter = selectedLetters.removeAt(selectedIndex);
      scrambledLetters.add(letter);
    });
  }

  /// The only way the game checks an answer and advances - tapping the
  /// next/check button. A correct answer shows the brief success feedback
  /// before moving on; a wrong-but-complete answer advances immediately.
  void _manualAdvance(List<GameData> questions) {
    final question = questions[currentStep];
    final word = _wordFor(question);
    if (selectedLetters.length != _lettersOf(word).length || isChecking) return;

    final formed = selectedLetters.join();
    historyList.add(QuestionResultModel(
      question: _imageFor(question),
      result: formed,
      correctAnswer: word,
    ));

    if (formed == word) {
      setState(() => isChecking = true);
      correctCount++;
      unawaited(SystemSound.play(SystemSoundType.click));
      Future.delayed(_successDelay, () => _advance(questions));
      return;
    }

    _advance(questions);
  }

  void _advance(List<GameData> questions) {
    if (!mounted) return;

    if (currentStep == questions.length - 1) {
      _goToResult(questions.length);
      return;
    }

    setState(() => currentStep++);
    _startQuestion(questions[currentStep]);
    _playAudio(questions[currentStep]);
  }

  void _goToResult(int totalSteps) {
    if (_hasNavigatedToResult) return;
    _hasNavigatedToResult = true;

    context.read<ScoreProvider>().recordScore(
        category: _isEnglish ? GameCategory.english : GameCategory.myanmar,
        gameTitle: _isEnglish ? GameTitle.enWordSort:GameTitle.mmWordSort, score: correctCount);
    context.replaceNamed(
      RouteName.resultView,
      extra: {
        'score': correctCount,
        'maxScore': totalSteps,
        'childWidget': SortResultView(historyList: List.of(historyList)),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7AEEFC),
      appBar: MyAppBar(titleWithGoBack: _isEnglish ? '${tr('word_sort')} ${tr('game')}' : 'စကားလုံးဆက်မယ်'),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/game_background.png"), fit: BoxFit.cover),
          ),
          child: BlocListener<GameBloc, GameState>(
            bloc: _gameBloc,
            // Scramble the first question's letters and auto-play its audio
            // only right as questions first load - later questions are
            // started from _advance instead.
            listenWhen: (previous, current) =>
                previous.wordSortingStatus != GameLoadStatus.success &&
                current.wordSortingStatus == GameLoadStatus.success,
            listener: (context, state) {
              if (state.wordSortingQuestions.isNotEmpty) {
                final firstQuestion = state.wordSortingQuestions.first;
                _startQuestion(firstQuestion);
                _playAudio(firstQuestion);
              }
            },
            child: BlocBuilder<GameBloc, GameState>(
              bloc: _gameBloc,
              builder: (context, state) {
                if (state.wordSortingStatus == GameLoadStatus.loading ||
                    state.wordSortingStatus == GameLoadStatus.initial) {
                  return Center(child: CircularProgressIndicator(color: ColorResources.primary));
                }

                if (state.wordSortingStatus == GameLoadStatus.failure) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => _gameBloc.add(WordSortingGameRequested(subject: widget.subject)),
                      child: Text(
                        'Failed to load. Tap to retry.',
                        style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen),
                      ),
                    ),
                  );
                }

                final questions = state.wordSortingQuestions;
                if (questions.isEmpty) {
                  return Center(
                    child: Text(tr('no_data'), style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen)),
                  );
                }

                final question = questions[currentStep];
                final word = _wordFor(question);
                final isAnswerFilled = selectedLetters.length == _lettersOf(word).length;

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ProgressBarView(currentStep: currentStep + 1, totalSteps: questions.length),
                          SizedBox(height: 24),
                          AudioPromptView(
                            description: 'Listen and arrange',
                            onPlayAudio: () => _playAudio(question),
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            width: context.width * 0.45,
                            height: context.width * 0.45,
                            child: FrontFlipCardItem(image: _imageFor(question), isSelected: false),
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              // Myanmar letters only ligate when they share one Text run,
                              // so non-English answers are joined; tap removes the last letter.
                              if (_isEnglish)
                                ...selectedLetters.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _deselectLetter(entry.key),
                                    child: Text(
                                      entry.value.toUpperCase(),
                                      style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                                    ),
                                  );
                                })
                              else if (selectedLetters.isNotEmpty)
                                GestureDetector(
                                  onTap: () => _deselectLetter(selectedLetters.length - 1),
                                  child: Text(
                                    selectedLetters.join(),
                                    style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                                  ),
                                ),
                              ...List.generate(
                                _lettersOf(word).length - selectedLetters.length,
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
                            children: scrambledLetters.asMap().entries.map((entry) {
                              return LetterTileView(
                                letter: entry.value,
                                size: context.width * 0.16,
                                onTap: isChecking ? null : () => _selectLetter(entry.key),
                              );
                            }).toList(),
                          ),
                          // SizedBox(height: 90),
                        ],
                      ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 40 + MediaQuery.of(context).padding.bottom,
                      child: GestureDetector(
                        onTap: (){
                          if(isAnswerFilled) {
                            _audioPlayer.play(AssetSource('audios/pop.mp3'));
                            _manualAdvance(questions);
                          }
                          // isAnswerFilled ? () => _manualAdvance(questions) : null;
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
                          decoration: isAnswerFilled ? selectedDecoration() : unselectedDecoration(),
                          child: currentStep == questions.length - 1
                              ? Text(tr('check'), style: FontFamily().medium)
                              : SvgPicture.asset("assets/icons/next.svg"),
                        ),
                      ),
                    ),
                    // Positioned.fill(
                    //   child: Center(child: SuccessFeedbackView(visible: isChecking)),
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
