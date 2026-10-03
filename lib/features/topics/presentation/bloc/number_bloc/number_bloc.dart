// Path: features/topics/presentation/bloc/number_bloc/number_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/response_ob.dart';
import '../../../data/model/number_model.dart';
import '../../../domain/repositories/number_repo.dart';

part '../number_event.dart';
part '../number_state.dart';

class NumberBloc extends Bloc<NumberEvent, NumberState> {
  final NumberRepo repository;

  NumberBloc(this.repository) : super(const NumberState()) {
    on<NumbersRequested>(_onNumbersRequested);
  }

  Future<void> _onNumbersRequested(
      NumbersRequested event, Emitter<NumberState> emit) async {
    emit(state.copyWith(status: NumbersStatus.loading));
    try {
      final response = await repository.getNumbers(
        subject: event.subject,
        page: event.page,
        forceRefresh: event.forceRefresh,
      );
      if (response.message == MsgState.data) {
        final model = NumberListModel.fromJson(response.data);
        emit(state.copyWith(
          status: NumbersStatus.success,
          numbers: model.data ?? [],
          currentPage: model.meta?.currentPage ?? event.page,
          lastPage: model.meta?.lastPage ?? event.page,
        ));
      } else {
        emit(state.copyWith(status: NumbersStatus.failure, error: response));
      }
    } catch (e) {
      emit(state.copyWith(
        status: NumbersStatus.failure,
        error: ResponseOb(errState: ErrState.unknown_err),
      ));
    }
  }
}
