// Path: config/global_context.dart
import 'package:flutter/material.dart';

class GlobalContext {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}