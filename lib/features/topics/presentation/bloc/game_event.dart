// Path: features/topics/presentation/bloc/game_event.dart
part of 'game_bloc/game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

/// [subject] is 'en' for the English choose-picture game, 'my' for the
/// Myanmar one.
class ChoosePictureGameRequested extends GameEvent {
  final String subject;

  const ChoosePictureGameRequested({required this.subject});

  @override
  List<Object?> get props => [subject];
}

/// [subject] is 'en' for the English word-sorting game, 'my' for the
/// Myanmar one.
class WordSortingGameRequested extends GameEvent {
  final String subject;

  const WordSortingGameRequested({required this.subject});

  @override
  List<Object?> get props => [subject];
}

/// [subject] is 'en' for the English sentence-sorting game, 'my' for the
/// Myanmar one.
class SentenceSortingGameRequested extends GameEvent {
  final String subject;

  const SentenceSortingGameRequested({required this.subject});

  @override
  List<Object?> get props => [subject];
}
