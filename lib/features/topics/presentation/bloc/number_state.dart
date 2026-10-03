// Path: features/topics/presentation/bloc/number_state.dart
part of 'number_bloc/number_bloc.dart';

enum NumbersStatus { initial, loading, success, failure }

class NumberState extends Equatable {
  final NumbersStatus status;
  final List<NumberData> numbers;
  final int currentPage;
  final int lastPage;
  final ResponseOb? error;

  const NumberState({
    this.status = NumbersStatus.initial,
    this.numbers = const [],
    this.currentPage = 1,
    this.lastPage = 1,
    this.error,
  });

  bool get hasPrev => currentPage > 1;
  bool get hasNext => currentPage < lastPage;

  NumberState copyWith({
    NumbersStatus? status,
    List<NumberData>? numbers,
    int? currentPage,
    int? lastPage,
    ResponseOb? error,
  }) {
    return NumberState(
      status: status ?? this.status,
      numbers: numbers ?? this.numbers,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, numbers, currentPage, lastPage, error];
}
