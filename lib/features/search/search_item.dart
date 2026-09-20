// Path: search/search_item.dart
import 'package:flutter/material.dart';

enum SearchTabType { vocabulary, game, poem, other }

class SearchItem {
  /// Localization keys that make up the title, joined with a space when displayed
  /// (e.g. ['word', 'game'] -> "Word Game" / "စကားလုံး ဂိမ်း").
  final List<String> titleKeys;
  final String categoryKey;
  final SearchTabType type;
  final String iconAsset;
  final Color badgeColor;
  final VoidCallback onTap;

  const SearchItem({
    required this.titleKeys,
    required this.categoryKey,
    required this.type,
    required this.iconAsset,
    required this.badgeColor,
    required this.onTap,
  });
}

class SearchTopic {
  final String titleKey;
  final String iconAsset;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  const SearchTopic({
    required this.titleKey,
    required this.iconAsset,
    required this.background,
    required this.foreground,
    required this.onTap,
  });
}
