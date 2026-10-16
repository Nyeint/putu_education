// Path: features/topics/presentation/bloc/game_bloc/game_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/response_ob.dart';
import '../../../data/model/game_model.dart';
import '../../../domain/repositories/game_repo.dart';

part '../game_event.dart';
part '../game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepo repository;

  GameBloc(this.repository) : super(const GameState()) {
    on<ChoosePictureGameRequested>(_onChoosePictureGameRequested);
    on<WordSortingGameRequested>(_onWordSortingGameRequested);
    on<SentenceSortingGameRequested>(_onSentenceSortingGameRequested);
  }

  Future<void> _onChoosePictureGameRequested(
      ChoosePictureGameRequested event, Emitter<GameState> emit) async {
    emit(state.copyWith(choosePictureStatus: GameLoadStatus.loading));
    try {
      final response = await repository.getChoosePictureGame(subject: event.subject, forceRefresh: event.forceRefresh);
      if (response.message == MsgState.data) {
        final model = GameModel.fromJson(response.data);
        emit(state.copyWith(
          choosePictureStatus: GameLoadStatus.success,
          choosePictureQuestions: model.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          choosePictureStatus: GameLoadStatus.failure,
          choosePictureError: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        choosePictureStatus: GameLoadStatus.failure,
        choosePictureError: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }

  Future<void> _onWordSortingGameRequested(
      WordSortingGameRequested event, Emitter<GameState> emit) async {
    emit(state.copyWith(wordSortingStatus: GameLoadStatus.loading));
    try {
      final response = await repository.getWordSortingGame(subject: event.subject, forceRefresh: event.forceRefresh);
      if (response.message == MsgState.data) {
        final model = GameModel.fromJson(response.data);
        emit(state.copyWith(
          wordSortingStatus: GameLoadStatus.success,
          wordSortingQuestions: model.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          wordSortingStatus: GameLoadStatus.failure,
          wordSortingError: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        wordSortingStatus: GameLoadStatus.failure,
        wordSortingError: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }

  Future<void> _onSentenceSortingGameRequested(
      SentenceSortingGameRequested event, Emitter<GameState> emit) async {
    emit(state.copyWith(sentenceSortingStatus: GameLoadStatus.loading));
    try {
      final response = await repository.getSentenceSortingGame(subject: event.subject, forceRefresh: event.forceRefresh);
      if (response.message == MsgState.data) {
        final model = GameModel.fromJson(response.data);
        emit(state.copyWith(
          sentenceSortingStatus: GameLoadStatus.success,
          sentenceSortingQuestions: model.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          sentenceSortingStatus: GameLoadStatus.failure,
          sentenceSortingError: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        sentenceSortingStatus: GameLoadStatus.failure,
        sentenceSortingError: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }
}
