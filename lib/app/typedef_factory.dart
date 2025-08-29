import 'package:flutter/material.dart';
import '../data/model/response_ob.dart';
import '../data/single_ui_builder/single_ui_builder.dart';

typedef SuccessCallback = void Function(ResponseOb resp);
typedef CustomMoreCallback = void Function(ResponseOb resp);
typedef CustomErrorCallback = void Function(ResponseOb resp);
typedef MainWidget = Widget Function(dynamic data, RefreshLoad reload);
typedef More = Widget Function(dynamic data, RefreshLoad reload);