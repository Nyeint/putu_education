// Path: features/topics/presentation/bloc/poemtory_bloc/poemtory_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/response_ob.dart';
import '../../../data/model/poemtory_list_model.dart';
import '../../../domain/repositories/poemtory_repo.dart';

part '../poemtory_event.dart';
part '../poemtory_state.dart';

class PoemToryBloc extends Bloc<PoemToryEvent, PoemToryState> {
  final PoemToryRepo repository;

  PoemToryBloc(this.repository) : super(const PoemToryState()) {
    on<PoemToriesRequested>(_onPoemToriesRequested);
    on<PoemToriesRefreshRequested>(_onPoemToriesRefreshRequested);
    on<PoemToriesLoadMoreRequested>(_onPoemToriesLoadMoreRequested);
  }

  Future<void> _onPoemToriesRequested(
      PoemToriesRequested event, Emitter<PoemToryState> emit) async {
    emit(state.copyWith(status: PoemToriesStatus.loading));
    await _fetchPage(
      poemtoryType: event.poemtoryType,
      subject: event.subject,
      page: 1,
      forceRefresh: false,
      replace: true,
      emit: emit,
    );
  }

  Future<void> _onPoemToriesRefreshRequested(
      PoemToriesRefreshRequested event, Emitter<PoemToryState> emit) async {
    // No Loading state here - pull-to-refresh shows its own spinner and the
    // existing list should stay on screen while the fresh page loads.
    emit(state.copyWith(isRefreshing: true));
    await _fetchPage(
      poemtoryType: event.poemtoryType,
      subject: event.subject,
      page: 1,
      forceRefresh: true,
      replace: true,
      emit: emit,
    );
  }

  Future<void> _onPoemToriesLoadMoreRequested(
      PoemToriesLoadMoreRequested event, Emitter<PoemToryState> emit) async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    await _fetchPage(
      poemtoryType: event.poemtoryType,
      subject: event.subject,
      page: state.currentPage + 1,
      forceRefresh: false,
      replace: false,
      emit: emit,
    );
  }

  Future<void> _fetchPage({
    required String poemtoryType,
    required String subject,
    required int page,
    required bool forceRefresh,
    required bool replace,
    required Emitter<PoemToryState> emit,
  }) async {
    try {
      final response = await repository.getPoemTories(
        poemtoryType: poemtoryType,
        subject: subject,
        page: page,
        forceRefresh: forceRefresh,
      );
      if (response.message == MsgState.data) {
        final model = PoemToryListModel.fromJson(response.data);
        final newItems = model.data ?? [];
        final meta = model.meta;
        final hasMore = meta?.currentPage != null && meta?.lastPage != null
            ? meta!.currentPage! < meta.lastPage!
            : false;
        final poemtories =
            replace ? newItems : [...state.poemtories, ...newItems];
        emit(state.copyWith(
          status: PoemToriesStatus.success,
          poemtories: poemtories,
          currentPage: meta?.currentPage ?? page,
          hasMore: hasMore,
          isRefreshing: false,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(
          status: replace ? PoemToriesStatus.failure : state.status,
          error: response,
          isRefreshing: false,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: replace ? PoemToriesStatus.failure : state.status,
        error: ResponseOb(errState: ErrState.unknown_err),
        isRefreshing: false,
        isLoadingMore: false,
      ));
    }
  }
}
