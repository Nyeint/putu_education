// Path: topics/presentation/pages/games/sentence_sort_game.dart
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
import 'package:putu_education/features/game/widgets/progress_bar.dart';
import 'package:putu_education/features/game/widgets/word_tile_view.dart';
import 'package:putu_education/features/widgets/item_decoration.dart';
import 'package:putu_education/features/widgets/my_appbar.dart';
import 'package:putu_education/route/route_name.dart';
import '../../../data/model/game_model.dart';
import '../../../domain/repositories/game_repo.dart';
import '../../bloc/game_bloc/game_bloc.dart';

/// Sentence Sorting game: fetches a set of sentences from
/// `GET games/sentence-sorting?subject=en|my` and has the player arrange
/// word tiles (`options.tiles`, shuffled client-side - the API sends them in
/// the correct order) back into the correct sentence (`target_text`).
/// Arranging a sentence correctly scores 1 point.
///
/// [subject] selects both the API language and which of a question's
/// bilingual audio fields is played: 'en' uses `audio`; anything else (the
/// API's 'my') uses `audio_mm`.
class EnglishSentenceSortGame extends StatefulWidget {
  final String subject;

  const EnglishSentenceSortGame({super.key, this.subject = 'en'});

  @override
  State<EnglishSentenceSortGame> createState() => _EnglishSentenceSortGameState();
}

class _EnglishSentenceSortGameState extends State<EnglishSentenceSortGame> {
  final GameBloc _gameBloc = getIt<GameBloc>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();

  static const Duration _successDelay = Duration(seconds: 1);

  int currentStep = 0;
  List<String> selectedTiles = [];
  List<String> tilePool = [];

  /// True while an answer is fully filled in and being validated/animated -
  /// tile taps are ignored during this window so the board can't change
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
    final hasCache = await getIt<GameRepo>().hasSentenceSortingCache(subject: widget.subject);
    final forceRefresh = hasCache && mounted ? await showChooseQuestionsAlert(context) : false;
    if (!mounted) return;
    _gameBloc.add(SentenceSortingGameRequested(subject: widget.subject, forceRefresh: forceRefresh));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _gameBloc.close();
    super.dispose();
  }

  /// The word tiles for [question], in the (correct) order the API sends
  /// them under `options[0].tiles`. Callers that display these to the player
  /// must shuffle them first via [_shuffledTilesOf] - this raw order is the
  /// answer.
  List<String> _tilesFor(GameData question) {
    final options = question.options;
    if (options == null || options.isEmpty) return [];
    return options.first.tiles ?? [];
  }

  List<String> _shuffledTilesOf(List<String> tiles) {
    if (tiles.length <= 1) return List<String>.from(tiles);

    List<String> shuffled;
    do {
      shuffled = List<String>.from(tiles)..shuffle(_random);
    } while (shuffled.join(' ') == tiles.join(' '));
    return shuffled;
  }

  /// The correct sentence to match against. Normally `target_text`; falls
  /// back to the tiles' raw (correct) order in case it's ever missing.
  String _targetFor(GameData question) {
    final target = question.targetText?.trim();
    if (target != null && target.isNotEmpty) return target;
    return _tilesFor(question).join(' ').trim();
  }

  String _imageFor(GameData question) => question.lesson?.imageUrl ?? question.image ?? '';

  String _audioUrl(GameData question) => (_isEnglish ? question.audio : question.audioMm) ?? '';

  /// Plays the question's pre-recorded audio (no TTS involved).
  Future<void> _playAudio(GameData question) async {
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

  void _startQuestion(GameData question) {
    setState(() {
      tilePool = _shuffledTilesOf(_tilesFor(question));
      selectedTiles = [];
      isChecking = false;
    });
  }

  /// Moves the tile at [poolIndex] into the answer blanks.
  void _selectTile(int poolIndex) {
    if (isChecking) return;
    setState(() {
      final tile = tilePool.removeAt(poolIndex);
      selectedTiles.add(tile);
    });
  }

  /// Returns the filled tile at [selectedIndex] back to the tile pool.
  void _deselectTile(int selectedIndex) {
    if (isChecking) return;
    setState(() {
      final tile = selectedTiles.removeAt(selectedIndex);
      tilePool.add(tile);
    });
  }

  /// The only way the game checks an answer and advances - tapping the
  /// next/check button. A correct answer shows the brief success feedback
  /// before moving on; a wrong-but-complete answer advances immediately.
  void _manualAdvance(List<GameData> questions) {
    final question = questions[currentStep];
    final totalTiles = _tilesFor(question).length;
    if (selectedTiles.length != totalTiles || isChecking) return;

    final formed = selectedTiles.join(' ').trim();
    final target = _targetFor(question);
    historyList.add(QuestionResultModel(
      question: _imageFor(question),
      result: formed,
      correctAnswer: target,
    ));

    final noSpaceFormed = formed.replaceAll(RegExp(r'\s+'), '');
    final noSpaceTarget = target.replaceAll(RegExp(r'\s+'), '');
    if (noSpaceFormed == noSpaceTarget) {
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
        category: _isEnglish?GameCategory.english:GameCategory.myanmar,
        gameTitle: _isEnglish?GameTitle.enSentenceSort:GameTitle.mmSentenceSort, score: correctCount);
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
      appBar: MyAppBar(titleWithGoBack: '${tr('sentence_sort')} ${tr('game')}'),
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
            // Load the first question's tiles and auto-play its audio only
            // right as questions first load - later questions are started
            // from _advance instead.
            listenWhen: (previous, current) =>
                previous.sentenceSortingStatus != GameLoadStatus.success &&
                current.sentenceSortingStatus == GameLoadStatus.success,
            listener: (context, state) {
              if (state.sentenceSortingQuestions.isNotEmpty) {
                final firstQuestion = state.sentenceSortingQuestions.first;
                _startQuestion(firstQuestion);
                _playAudio(firstQuestion);
              }
            },
            child: BlocBuilder<GameBloc, GameState>(
              bloc: _gameBloc,
              builder: (context, state) {
                if (state.sentenceSortingStatus == GameLoadStatus.loading ||
                    state.sentenceSortingStatus == GameLoadStatus.initial) {
                  return Center(child: CircularProgressIndicator(color: ColorResources.primary));
                }

                if (state.sentenceSortingStatus == GameLoadStatus.failure) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => _gameBloc.add(SentenceSortingGameRequested(subject: widget.subject)),
                      child: Text(
                        'Failed to load. Tap to retry.',
                        style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen),
                      ),
                    ),
                  );
                }

                final questions = state.sentenceSortingQuestions;
                if (questions.isEmpty) {
                  return Center(
                    child: Text(tr('no_data'), style: FontFamily().medium.copyWith(fontSize: FontSize().sixteen)),
                  );
                }

                final question = questions[currentStep];
                final totalTiles = _tilesFor(question).length;
                final isAnswerFilled = selectedTiles.length == totalTiles;

                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ProgressBarView(currentStep: currentStep + 1, totalSteps: questions.length),

                          if(question.audio != null || question.audioMm != null)
                            ...[
                              SizedBox(height: 24),
                              AudioPromptView(
                                description: 'Listen and arrange',
                                onPlayAudio: () => _playAudio(question),
                              ),
                            ],

                          SizedBox(height: 40),
                          SizedBox(
                            width: context.height*0.25,
                            height: context.height*0.25,
                            // width: context.width * 0.45,
                            // height: context.width * 0.45,
                            child: FrontFlipCardItem(image: _imageFor(question), isSelected: true),
                          ),
                          SizedBox(height: 30),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...selectedTiles.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _deselectTile(entry.key),
                                  child: Text(
                                    entry.value,
                                    style: FontFamily().semiBold.copyWith(fontSize: FontSize().thirtyTwo),
                                  ),
                                );
                              }),
                              ...List.generate(
                                totalTiles - selectedTiles.length,
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
                            children: tilePool.asMap().entries.map((entry) {
                              return WordTileView(
                                word: entry.value,
                                onTap: isChecking ? null : () => _selectTile(entry.key),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 90),
                        ],
                      ).pad(left: 16, right: 16, top: 24, bottom: MediaQuery.of(context).padding.bottom),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 80 + MediaQuery.of(context).padding.bottom,
                      child: GestureDetector(
                        onTap: (){
                          if(isAnswerFilled){
                            _audioPlayer.play(AssetSource('audios/pop.mp3'));
                            _manualAdvance(questions);
                          }
                        },
                        child:
                        // Container(
                        //   padding: EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
                        //   decoration: isAnswerFilled ? selectedDecoration() : unselectedDecoration(),
                        //   child: currentStep == questions.length - 1
                        //       ? Text(tr('check'), style: FontFamily().medium)
                        //       : SvgPicture.asset("assets/icons/next.svg"),
                        // ),
                        Container(
                          width: context.width * 0.3,
                          height: context.width * 0.3,
                          child:
                          Image.asset('assets/icons/${currentStep == questions.length - 1?'check':isAnswerFilled ?'next_active':'next_inactive'}.png', fit: BoxFit.contain,),
                        )
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
