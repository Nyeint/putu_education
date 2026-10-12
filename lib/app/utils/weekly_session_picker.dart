// Path: utils/weekly_session_picker.dart
import 'dart:math';

import 'package:putu_education/data/model/session_item.dart';

/// Picks a deterministic random subset of [SessionItem.all] that stays the
/// same for every user for a whole week, then reshuffles on the next week.
///
/// Determinism comes from seeding [Random] with a number derived from the
/// current year + week-of-year, so the same 4 sessions are shown to everyone
/// until the week rolls over, without needing any backend/storage.
class WeeklySessionPicker {
  WeeklySessionPicker._();

  static const int pickCount = 4;

  /// Returns [pickCount] sessions drawn from all 16, stable for the week
  /// containing [now] (defaults to the current time).
  static List<SessionItem> pick({DateTime? now}) {
    final date = now ?? DateTime.now();
    final seed = _weekSeed(date);
    final shuffled = List<SessionItem>.from(SessionItem.all)
      ..shuffle(Random(seed));
    return shuffled.take(pickCount).toList();
  }

  static int _dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  }

  static int _weekSeed(DateTime date) {
    final weekOfYear = (_dayOfYear(date) / 7).floor();
    return date.year * 100 + weekOfYear;
  }
}
