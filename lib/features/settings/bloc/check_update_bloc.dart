import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/model/response_ob.dart';
import '../domain/check_update_repo.dart';
import '../model/check_update_model.dart';

class CheckUpdateEvent extends Equatable {
  const CheckUpdateEvent();
  @override
  List<Object?> get props => [];
}

abstract class CheckUpdateState extends Equatable {
  const CheckUpdateState();
  @override
  List<Object?> get props => [];
}

class CheckUpdateInitial extends CheckUpdateState {
  const CheckUpdateInitial();
}

class CheckUpdateLoading extends CheckUpdateState {
  const CheckUpdateLoading();
}

class CheckUpdateSuccess extends CheckUpdateState {
  final CheckUpdateData data;
  const CheckUpdateSuccess(this.data);
  @override
  List<Object?> get props => [data.latestVersion, data.updateAvailable];
}

class CheckUpdateFailure extends CheckUpdateState {
  final ResponseOb errorResponse;
  const CheckUpdateFailure(this.errorResponse);
  @override
  List<Object?> get props => [errorResponse];
}

class CheckUpdateBloc extends Bloc<CheckUpdateEvent, CheckUpdateState> {
  final CheckUpdateRepo repository;

  CheckUpdateBloc(this.repository) : super(const CheckUpdateInitial()) {
    on<CheckUpdateEvent>(_onCheck);
  }

  Future<void> _onCheck(
      CheckUpdateEvent event, Emitter<CheckUpdateState> emit) async {
    emit(const CheckUpdateLoading());
    try {
      final info = await PackageInfo.fromPlatform();
      final response = await repository.checkVersion(
        platform: Platform.isIOS ? 'ios' : 'android',
        version: info.version,
        buildNumber: info.buildNumber,
      );
      final data = response.message == MsgState.data
          ? CheckUpdateModel.fromJson(response.data).data
          : null;
      if (data != null) {
        emit(CheckUpdateSuccess(data));
      } else {
        emit(CheckUpdateFailure(response));
      }
    } catch (e) {
      emit(CheckUpdateFailure(ResponseOb(errState: ErrState.unknown_err)));
    }
  }
}
