// Path: features/topics/presentation/bloc/game_state.dart
part of 'game_bloc/game_bloc.dart';

enum GameLoadStatus { initial, loading, success, failure }

/// A single flat state holding every game's questions, tracked independently
/// (same shape as `VocabState`) - so loading one game never wipes out
/// another's already-loaded questions.
class GameState extends Equatable {
  final GameLoadStatus choosePictureStatus;
  final List<GameData> choosePictureQuestions;
  final ResponseOb? choosePictureError;

  final GameLoadStatus wordSortingStatus;
  final List<GameData> wordSortingQuestions;
  final ResponseOb? wordSortingError;

  final GameLoadStatus sentenceSortingStatus;
  final List<GameData> sentenceSortingQuestions;
  final ResponseOb? sentenceSortingError;

  const GameState({
    this.choosePictureStatus = GameLoadStatus.initial,
    this.choosePictureQuestions = const [],
    this.choosePictureError,
    this.wordSortingStatus = GameLoadStatus.initial,
    this.wordSortingQuestions = const [],
    this.wordSortingError,
    this.sentenceSortingStatus = GameLoadStatus.initial,
    this.sentenceSortingQuestions = const [],
    this.sentenceSortingError,
  });

  GameState copyWith({
    GameLoadStatus? choosePictureStatus,
    List<GameData>? choosePictureQuestions,
    ResponseOb? choosePictureError,
    GameLoadStatus? wordSortingStatus,
    List<GameData>? wordSortingQuestions,
    ResponseOb? wordSortingError,
    GameLoadStatus? sentenceSortingStatus,
    List<GameData>? sentenceSortingQuestions,
    ResponseOb? sentenceSortingError,
  }) {
    return GameState(
      choosePictureStatus: choosePictureStatus ?? this.choosePictureStatus,
      choosePictureQuestions: choosePictureQuestions ?? this.choosePictureQuestions,
      choosePictureError: choosePictureError ?? this.choosePictureError,
      wordSortingStatus: wordSortingStatus ?? this.wordSortingStatus,
      wordSortingQuestions: wordSortingQuestions ?? this.wordSortingQuestions,
      wordSortingError: wordSortingError ?? this.wordSortingError,
      sentenceSortingStatus: sentenceSortingStatus ?? this.sentenceSortingStatus,
      sentenceSortingQuestions: sentenceSortingQuestions ?? this.sentenceSortingQuestions,
      sentenceSortingError: sentenceSortingError ?? this.sentenceSortingError,
    );
  }

  @override
  List<Object?> get props => [
        choosePictureStatus,
        choosePictureQuestions,
        choosePictureError,
        wordSortingStatus,
        wordSortingQuestions,
        wordSortingError,
        sentenceSortingStatus,
        sentenceSortingQuestions,
        sentenceSortingError,
      ];
}
