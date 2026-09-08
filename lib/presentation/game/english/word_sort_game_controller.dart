// Path: english/word_sort_game_controller.dart
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../model/question_result.dart';
import '../model/word_question.dart';
import 'word_sorting_repository.dart';

/// Drives the 10-question Word Sorting Game flow: fetching questions,
/// scrambling/selecting letters, validating answers and advancing.
///
/// The view layer only reads state off this controller and forwards taps —
/// all shuffling, validation and auto-advance timing lives here so it can be
/// reasoned about (and tested) independently of any widget.
class WordSortGameController extends ChangeNotifier {
  WordSortGameController({
    WordSortingRepository? repository,
    AudioPlayer? audioPlayer,
    Random? random,
  })  : _repository = repository ?? const WordSortingRepository(),
        _audioPlayer = audioPlayer ?? AudioPlayer(),
        _random = random ?? Random();

  final WordSortingRepository _repository;
  final AudioPlayer _audioPlayer;
  final Random _random;

  static const int questionCount = 10;
  static const Duration successDelay = Duration(seconds: 1);

  List<WordQuestion> questions = [];
  int currentIndex = 0;
  List<String> selectedLetters = [];
  List<String> scrambledLetters = [];
  bool isCompleted = false;
  bool isLoading = true;

  /// True while an answer is fully filled in and being validated/animated —
  /// letter taps are ignored during this window so the board can't change
  /// mid-feedback.
  bool isChecking = false;

  int correctCount = 0;
  final List<QuestionResultModel> historyList = [];

  WordQuestion get currentQuestion => questions[currentIndex];

  double get progress => questions.isEmpty ? 0 : (currentIndex + 1) / questions.length;

  String get progressLabel => '${currentIndex + 1}/${questions.length}';

  bool get isAnswerFilled =>
      questions.isNotEmpty && selectedLetters.length == currentQuestion.word.length;

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
    scrambledLetters = _shuffledLettersOf(currentQuestion.word);
    selectedLetters = [];
    isChecking = false;
  }

  List<String> _shuffledLettersOf(String word) {
    final letters = word.split('');
    if (letters.length <= 1) return letters;

    List<String> shuffled;
    do {
      shuffled = List<String>.from(letters)..shuffle(_random);
    } while (shuffled.join() == word);
    return shuffled;
  }

  Future<void> playCurrentAudio() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(currentQuestion.audioUrl));
    } catch (e) {
      print("Failed to play audio: ${currentQuestion.audioUrl} and ${e.toString()} and ${currentQuestion.audioUrl}");
      // Swallow playback failures (e.g. unreachable mock CDN) — audio is a
      // supplementary hint, not a blocker for playing the game.
    }
  }

  /// Moves the scrambled letter at [poolIndex] into the answer blanks.
  /// Filling the last blank never checks or advances by itself — the player
  /// can still remove letters to retry, and must tap the next/check button
  /// (see [manualAdvance]) to have the answer validated and move on.
  void selectLetter(int poolIndex) {
    if (isChecking) return;

    final letter = scrambledLetters.removeAt(poolIndex);
    selectedLetters.add(letter);
    notifyListeners();
  }

  /// Returns the filled letter at [selectedIndex] back to the letter pool.
  void deselectLetter(int selectedIndex) {
    if (isChecking) return;

    final letter = selectedLetters.removeAt(selectedIndex);
    scrambledLetters.add(letter);
    notifyListeners();
  }

  Future<void> _handleCorrectAnswer() async {
    isChecking = true;
    correctCount++;
    historyList.add(QuestionResultModel(
      question: currentQuestion.imageUrl,
      result: selectedLetters.join(),
      correctAnswer: currentQuestion.word,
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

    if (selectedLetters.join() == currentQuestion.word) {
      _handleCorrectAnswer();
      return;
    }

    historyList.add(QuestionResultModel(
      question: currentQuestion.imageUrl,
      result: selectedLetters.join(),
      correctAnswer: currentQuestion.word,
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
    _audioPlayer.dispose();
    super.dispose();
  }
}
