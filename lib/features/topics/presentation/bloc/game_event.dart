// Path: features/topics/presentation/bloc/game_event.dart
part of 'game_bloc/game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

/// [subject] is 'en' for the English choose-picture game, 'my' for the
/// Myanmar one. [forceRefresh] skips the cache and fetches a fresh set.
class ChoosePictureGameRequested extends GameEvent {
  final String subject;
  final bool forceRefresh;

  const ChoosePictureGameRequested({required this.subject, this.forceRefresh = false});

  @override
  List<Object?> get props => [subject, forceRefresh];
}

/// [subject] is 'en' for the English word-sorting game, 'my' for the
/// Myanmar one. [forceRefresh] skips the cache and fetches a fresh set.
class WordSortingGameRequested extends GameEvent {
  final String subject;
  final bool forceRefresh;

  const WordSortingGameRequested({required this.subject, this.forceRefresh = false});

  @override
  List<Object?> get props => [subject, forceRefresh];
}

/// [subject] is 'en' for the English sentence-sorting game, 'my' for the
/// Myanmar one. [forceRefresh] skips the cache and fetches a fresh set.
class SentenceSortingGameRequested extends GameEvent {
  final String subject;
  final bool forceRefresh;

  const SentenceSortingGameRequested({required this.subject, this.forceRefresh = false});

  @override
  List<Object?> get props => [subject, forceRefresh];
}
