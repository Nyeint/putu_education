// Path: features/topics/presentation/bloc/vocab_event.dart
part of 'vocab_bloc/vocab_bloc.dart';

abstract class VocabEvent extends Equatable {
  const VocabEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesRequested extends VocabEvent {
  const CategoriesRequested();
}

/// [subject] is 'en' for the English vocabulary tab, 'my' for the Myanmar
/// one. [category] is the selected tab's category name (e.g. 'fruit');
/// null means the synthetic "All" tab, so no category filter is sent.
class VocabularyRequested extends VocabEvent {
  final String subject;
  final String? category;

  const VocabularyRequested({required this.subject, this.category});

  @override
  List<Object?> get props => [subject, category];
}

/// Pull-to-refresh: re-fetches both the category tabs and the vocabulary for
/// [subject]/[category] from the network (bypassing the 5 minute cache rule)
/// and overwrites both caches with the fresh results.
class VocabRefreshRequested extends VocabEvent {
  final String subject;
  final String? category;

  const VocabRefreshRequested({required this.subject, this.category});

  @override
  List<Object?> get props => [subject, category];
}
