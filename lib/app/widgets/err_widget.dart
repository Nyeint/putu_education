import 'package:flutter/material.dart';
import '../../data/model/response_ob.dart';
import 'err_state_widget/connection_timeout_widget.dart';
import 'err_state_widget/maintain_widget.dart';
import 'err_state_widget/no_internet_widget.dart';
import 'err_state_widget/not_found_widget.dart';
import 'err_state_widget/server_err_widget.dart';
import 'err_state_widget/too_many_request_widget.dart';
import 'err_state_widget/unknown_err_widget.dart';
import 'my_card.dart';

class ErrWidget extends StatelessWidget {
  ErrState? errState;
  Function func;

  ErrWidget(this.errState, this.func, {super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      hasBoxShadow: false,
      child: error(),
    );
  }

  Widget error() {
    if (errState == ErrState.no_internet) {
      return NoInternetWidget(fun: () {
        func();
      });
    }
    else if (errState == ErrState.not_found) {
      return NotFoundWidget();
    }
    else if (errState == ErrState.connection_timeout) {
      return ConnectionTimeoutWidget(fun: () {
        func();
      });
    } else if (errState == ErrState.too_many_request) {
      return TooManyRequestWidget(
        fun: () {
          func();
        },
      );
    } else if (errState == ErrState.server_error) {
      return ServerErrWidget(fun: () {
        func();
      });
    } else if (errState == ErrState.server_maintain) {
      return ServerMaintenance(
        fun: () {
          func();
        },
      );
    } else if (errState == ErrState.unknown_err) {
      return UnknownErrWidget(
        fun: () {
          func();
        },
      );
    } else {
      return UnknownErrWidget(
        fun: () {
          func();
        },
      );
    }
  }
}
