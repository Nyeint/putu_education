// Path: features/topics/presentation/bloc/poemtory_event.dart
part of 'poemtory_bloc/poemtory_bloc.dart';

abstract class PoemToryEvent extends Equatable {
  const PoemToryEvent();

  @override
  List<Object?> get props => [];
}

/// Initial load of page 1. Serves cached data when it's fresh (< 5 minutes
/// old) and non-empty; otherwise hits the network.
/// [poemtoryType] selects the content type (e.g. 'poem', 'story', 'song').
/// [subject] is 'en' for English, 'my' for Myanmar.
class PoemToriesRequested extends PoemToryEvent {
  final String poemtoryType;
  final String subject;

  const PoemToriesRequested({required this.poemtoryType, required this.subject});

  @override
  List<Object?> get props => [poemtoryType, subject];
}

/// Pull-to-refresh: always re-fetches page 1 from the network (bypassing the
/// 5 minute cache rule) and overwrites the cache with the fresh result.
class PoemToriesRefreshRequested extends PoemToryEvent {
  final String poemtoryType;
  final String subject;

  const PoemToriesRefreshRequested({required this.poemtoryType, required this.subject});

  @override
  List<Object?> get props => [poemtoryType, subject];
}

/// Requests the next page and appends it to the currently loaded list.
/// No-ops if there is no more data or a page is already loading.
class PoemToriesLoadMoreRequested extends PoemToryEvent {
  final String poemtoryType;
  final String subject;

  const PoemToriesLoadMoreRequested({required this.poemtoryType, required this.subject});

  @override
  List<Object?> get props => [poemtoryType, subject];
}
