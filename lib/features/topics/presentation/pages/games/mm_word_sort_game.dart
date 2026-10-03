// Path: topics/presentation/pages/games/mm_word_sort_game.dart
import 'package:flutter/material.dart';

import 'word_sort_game.dart';

/// Myanmar word sorting: same game as English, fed by
/// `GET games/word-sorting?subject=mm`.
class BurmeseWordSortGame extends StatelessWidget {
  const BurmeseWordSortGame({super.key});

  @override
  Widget build(BuildContext context) => const EnglishWordSortGame(subject: 'mm');
}
