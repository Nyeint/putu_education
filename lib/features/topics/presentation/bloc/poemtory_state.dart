// Path: features/topics/presentation/bloc/poemtory_state.dart
part of 'poemtory_bloc/poemtory_bloc.dart';

enum PoemToriesStatus { initial, loading, success, failure }

class PoemToryState extends Equatable {
  final PoemToriesStatus status;
  final List<PoemToryData> poemtories;
  final ResponseOb? error;
  final int currentPage;
  final bool hasMore;
  final bool isRefreshing;
  final bool isLoadingMore;

  const PoemToryState({
    this.status = PoemToriesStatus.initial,
    this.poemtories = const [],
    this.error,
    this.currentPage = 1,
    this.hasMore = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
  });

  PoemToryState copyWith({
    PoemToriesStatus? status,
    List<PoemToryData>? poemtories,
    ResponseOb? error,
    int? currentPage,
    bool? hasMore,
    bool? isRefreshing,
    bool? isLoadingMore,
  }) {
    return PoemToryState(
      status: status ?? this.status,
      poemtories: poemtories ?? this.poemtories,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props =>
      [status, poemtories, error, currentPage, hasMore, isRefreshing, isLoadingMore];
}
