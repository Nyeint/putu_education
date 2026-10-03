// Path: features/topics/presentation/bloc/alphabet_bloc/alphabet_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/response_ob.dart';
import '../../../data/model/alphabet_model.dart';
import '../../../domain/repositories/alphabet_repo.dart';

part '../alphabet_event.dart';
part '../alphabet_state.dart';

class AlphabetBloc extends Bloc<AlphabetEvent, AlphabetState> {
  final AlphabetRepo repository;

  AlphabetBloc(this.repository) : super(const AlphabetState()) {
    on<AlphabetsRequested>(_onAlphabetsRequested);
  }

  Future<void> _onAlphabetsRequested(
      AlphabetsRequested event, Emitter<AlphabetState> emit) async {
    emit(state.copyWith(status: AlphabetsStatus.loading));
    try {
      final response = await repository.getAlphabets(
        subject: event.subject,
        page: event.page,
        forceRefresh: event.forceRefresh,
      );
      if (response.message == MsgState.data) {
        final model = AlphabetListModel.fromJson(response.data);
        emit(state.copyWith(
          status: AlphabetsStatus.success,
          alphabets: model.data ?? [],
          currentPage: model.meta?.currentPage ?? event.page,
          lastPage: model.meta?.lastPage ?? event.page,
        ));
      } else {
        print("This is failure");
        emit(state.copyWith(status: AlphabetsStatus.failure, error: response));
      }
    } catch (e) {
      print("This is failure $e");

      emit(state.copyWith(
        status: AlphabetsStatus.failure,
        error: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }
}
