// Path: features/topics/presentation/bloc/number_event.dart
part of 'number_bloc/number_bloc.dart';

abstract class NumberEvent extends Equatable {
  const NumberEvent();

  @override
  List<Object?> get props => [];
}

/// Requests a page of numbers. [subject] is the API's language code (e.g.
/// 'mm' for Myanmar). [page] is the 1-based page to request. [forceRefresh]
/// bypasses the 10 second cache (pull-to-refresh) and overwrites it with the
/// fresh result.
class NumbersRequested extends NumberEvent {
  final String subject;
  final int page;
  final bool forceRefresh;

  const NumbersRequested({
    required this.subject,
    this.page = 1,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [subject, page, forceRefresh];
}
