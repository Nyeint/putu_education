// Path: features/topics/presentation/bloc/vocab_bloc/vocab_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/response_ob.dart';
import '../../../data/model/vocab_category_model.dart';
import '../../../data/model/vocab_word_model.dart';
import '../../../domain/repositories/vocab_repo.dart';

part '../vocab_event.dart';
part '../vocab_state.dart';

class VocabBloc extends Bloc<VocabEvent, VocabState> {
  final VocabRepo repository;

  VocabBloc(this.repository) : super(const VocabState()) {
    on<CategoriesRequested>(_onCategoriesRequested);
    on<VocabularyRequested>(_onVocabularyRequested);
    on<VocabRefreshRequested>(_onVocabRefreshRequested);
  }

  Future<void> _onCategoriesRequested(
      CategoriesRequested event, Emitter<VocabState> emit) async {
    emit(state.copyWith(categoriesStatus: CategoriesStatus.loading));
    await _loadCategories(forceRefresh: false, emit: emit);
  }

  Future<void> _loadCategories({
    required bool forceRefresh,
    required Emitter<VocabState> emit,
  }) async {
    try {
      final response = await repository.getCategories(forceRefresh: forceRefresh);
      if (response.message == MsgState.data) {
        final raw = response.data;
        final List<dynamic> rawList = raw is List
            ? raw
            : (raw is Map ? (raw['result'] ?? raw['data'] ?? []) : []);
        final categories =
            rawList.map((e) => VocabCategoryModel.fromJson(e)).toList();
        emit(state.copyWith(
          categoriesStatus: CategoriesStatus.success,
          categories: categories,
        ));
      } else {
        emit(state.copyWith(
          categoriesStatus: CategoriesStatus.failure,
          categoriesError: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        categoriesStatus: CategoriesStatus.failure,
        categoriesError: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }

  Future<void> _onVocabularyRequested(
      VocabularyRequested event, Emitter<VocabState> emit) async {
    emit(state.copyWith(vocabularyStatus: VocabularyStatus.loading));
    await _loadVocabulary(
      subject: event.subject,
      category: event.category,
      forceRefresh: false,
      emit: emit,
    );
  }

  Future<void> _loadVocabulary({
    required String subject,
    required String? category,
    required bool forceRefresh,
    required Emitter<VocabState> emit,
  }) async {
    try {
      final response = await repository.getVocabulary(
        subject: subject,
        category: category,
        forceRefresh: forceRefresh,
      );
      if (response.message == MsgState.data) {
        List<VocabWordData> vocabWordList = [];
        response.data['data'].forEach((v) {
          vocabWordList.add(VocabWordData.fromJson(v));
        });
        emit(state.copyWith(
          vocabularyStatus: VocabularyStatus.success,
          words: vocabWordList,
        ));
      } else {
        emit(state.copyWith(
          vocabularyStatus: VocabularyStatus.failure,
          vocabularyError: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        vocabularyStatus: VocabularyStatus.failure,
        vocabularyError: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }

  // Pull-to-refresh drives both requests as one user action, so they're
  // handled by a single handler with one isRefreshing flag rather than two
  // independent refresh events - running them as separate events/flags would
  // race, since either one finishing first would otherwise look like the
  // whole refresh had completed.
  Future<void> _onVocabRefreshRequested(
      VocabRefreshRequested event, Emitter<VocabState> emit) async {
    // No Loading state here - pull-to-refresh shows its own spinner and the
    // existing tabs/grid should stay on screen while the fresh data loads.
    emit(state.copyWith(isRefreshing: true));
    await _loadCategories(forceRefresh: true, emit: emit);
    await _loadVocabulary(
      subject: event.subject,
      category: event.category,
      forceRefresh: true,
      emit: emit,
    );
    emit(state.copyWith(isRefreshing: false));
  }
}
