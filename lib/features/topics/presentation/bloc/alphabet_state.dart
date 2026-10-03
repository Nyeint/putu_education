// Path: features/topics/presentation/bloc/alphabet_state.dart
part of 'alphabet_bloc/alphabet_bloc.dart';

enum AlphabetsStatus { initial, loading, success, failure }

class AlphabetState extends Equatable {
  final AlphabetsStatus status;
  final List<AlphabetData> alphabets;
  final int currentPage;
  final int lastPage;
  final ResponseOb? error;

  const AlphabetState({
    this.status = AlphabetsStatus.initial,
    this.alphabets = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.error,
  });

  bool get hasPrev => currentPage > 1;
  bool get hasNext => currentPage < lastPage;

  AlphabetState copyWith({
    AlphabetsStatus? status,
    List<AlphabetData>? alphabets,
    int? currentPage,
    int? lastPage,
    ResponseOb? error,
  }) {
    return AlphabetState(
      status: status ?? this.status,
      alphabets: alphabets ?? this.alphabets,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, alphabets, currentPage, lastPage, error];
}
