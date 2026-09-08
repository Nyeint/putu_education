// Path: english/sentence_sort_game_controller.dart
import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../model/question_result.dart';
import '../model/sentence_question.dart';
import 'sentence_sorting_repository.dart';

/// Drives the 10-question Sentence Sorting Game flow: fetching questions,
/// scrambling/selecting words, validating answers and advancing.
///
/// Mirrors [WordSortGameController] one level up (words instead of letters,
/// TTS instead of a pre-recorded clip) — the view layer only reads state off
/// this controller and forwards taps; all shuffling, validation and
/// auto-advance timing lives here so it can be reasoned about (and tested)
/// independently of any widget.
class SentenceSortGameController extends ChangeNotifier {
  SentenceSortGameController({
    SentenceSortingRepository? repository,
    FlutterTts? tts,
    Random? random,
  })  : _repository = repository ?? const SentenceSortingRepository(),
        _tts = tts ?? FlutterTts(),
        _random = random ?? Random();

  final SentenceSortingRepository _repository;
  final FlutterTts _tts;
  final Random _random;

  static const int questionCount = 10;
  static const Duration successDelay = Duration(seconds: 1);

  List<SentenceQuestion> questions = [];
  int currentIndex = 0;
  List<String> selectedWords = [];
  List<String> scrambledWords = [];
  bool isCompleted = false;
  bool isLoading = true;

  /// True while an answer is fully filled in and being validated/animated —
  /// word taps are ignored during this window so the board can't change
  /// mid-feedback.
  bool isChecking = false;

  int correctCount = 0;
  final List<QuestionResultModel> historyList = [];

  SentenceQuestion get currentQuestion => questions[currentIndex];

  double get progress => questions.isEmpty ? 0 : (currentIndex + 1) / questions.length;

  String get progressLabel => '${currentIndex + 1}/${questions.length}';

  bool get isAnswerFilled =>
      questions.isNotEmpty && selectedWords.length == currentQuestion.words.length;

  Future<void> loadQuestions({String language = 'en'}) async {
    isLoading = true;
    notifyListeners();

    questions = await _repository.fetchQuestions(limit: questionCount, language: language);
    currentIndex = 0;
    correctCount = 0;
    historyList.clear();
    isCompleted = false;
    _startQuestion();

    isLoading = false;
    notifyListeners();
  }

  void _startQuestion() {
    scrambledWords = _shuffledWordsOf(currentQuestion.words);
    selectedWords = [];
    isChecking = false;
  }

  List<String> _shuffledWordsOf(List<String> words) {
    if (words.length <= 1) return List<String>.from(words);

    List<String> shuffled;
    do {
      shuffled = List<String>.from(words)..shuffle(_random);
    } while (shuffled.join() == words.join());
    return shuffled;
  }

  Future<void> playCurrentAudio() async {
    try {
      await _tts.stop();
      await _tts.speak(currentQuestion.sentence);
    } catch (e) {
      // Swallow playback failures — audio is a supplementary hint, not a
      // blocker for playing the game.
    }
  }

  /// Moves the scrambled word at [poolIndex] into the answer blanks.
  /// Filling the last blank never checks or advances by itself — the player
  /// can still remove words to retry, and must tap the next/check button
  /// (see [manualAdvance]) to have the answer validated and move on.
  void selectWord(int poolIndex) {
    if (isChecking) return;

    final word = scrambledWords.removeAt(poolIndex);
    selectedWords.add(word);
    notifyListeners();
  }

  /// Returns the filled word at [selectedIndex] back to the word pool.
  void deselectWord(int selectedIndex) {
    if (isChecking) return;

    final word = selectedWords.removeAt(selectedIndex);
    scrambledWords.add(word);
    notifyListeners();
  }

  Future<void> _handleCorrectAnswer() async {
    isChecking = true;
    correctCount++;
    historyList.add(QuestionResultModel(
      question: currentQuestion.imageUrl,
      result: selectedWords.join(' '),
      correctAnswer: currentQuestion.sentence,
    ));
    unawaited(SystemSound.play(SystemSoundType.click));
    notifyListeners();

    await Future.delayed(successDelay);
    _advance();
  }

  /// The only way the game checks an answer and advances — tapping the
  /// next/check button. A correct answer shows the brief success feedback
  /// before moving on; a wrong-but-complete answer advances immediately. A
  /// no-op while blanks are still empty or a check is already in flight.
  void manualAdvance() {
    if (!isAnswerFilled || isChecking) return;

    if (selectedWords.join() == currentQuestion.words.join()) {
      _handleCorrectAnswer();
      return;
    }

    historyList.add(QuestionResultModel(
      question: currentQuestion.imageUrl,
      result: selectedWords.join(' '),
      correctAnswer: currentQuestion.sentence,
    ));
    _advance();
  }

  void _advance() {
    if (currentIndex == questions.length - 1) {
      isCompleted = true;
      isChecking = false;
      notifyListeners();
      return;
    }

    currentIndex++;
    _startQuestion();
    notifyListeners();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
