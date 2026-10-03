// Path: features/topics/presentation/bloc/alphabet_event.dart
part of 'alphabet_bloc/alphabet_bloc.dart';

abstract class AlphabetEvent extends Equatable {
  const AlphabetEvent();

  @override
  List<Object?> get props => [];
}

/// Requests a page of alphabets. [subject] is the API's language code (e.g.
/// 'mm' for Myanmar). [page] is the 1-based page to request. [forceRefresh]
/// bypasses the 10 second cache (pull-to-refresh) and overwrites it with the
/// fresh result.
class AlphabetsRequested extends AlphabetEvent {
  final String subject;
  final int page;
  final bool forceRefresh;

  const AlphabetsRequested({
    required this.subject,
    this.page = 1,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [subject, page, forceRefresh];
}
