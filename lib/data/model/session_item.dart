// Path: model/session_item.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/utils/en_types.dart';
import 'package:putu_education/route/my_router.dart';

import '../../features/topics/presentation/pages/math/math_view.dart';
import '../../features/topics/presentation/pages/poemtory/poemtory_list_view.dart';

/// Which top-level learning category a session belongs to.
enum SessionCategory { english, myanmar }

/// One learnable session (e.g. "Numbers", "Poems") that can show up in the
/// dashboard's "Top Pick" row.
///
/// There are 8 sessions per [SessionCategory] (english / myanmar), 16 total.
/// [WeeklySessionPicker] draws 4 of these at random, refreshed every week.
class SessionItem {
  final String id;
  final SessionCategory category;
  final String titleKey;
  final String iconName;
  final void Function(BuildContext context) onTap;

  const SessionItem({
    required this.id,
    required this.category,
    required this.titleKey,
    required this.iconName,
    required this.onTap,
  });

  /// All 16 sessions: 8 english + 8 myanmar.
  static final List<SessionItem> all = [
    // ---- English (8) ----
    SessionItem(
      id: 'en_numbers',
      category: SessionCategory.english,
      titleKey: 'Numbers',
      iconName: 'category_number',
      onTap: (context) => context.pushNamed(RouteName.englishNumber),
    ),
    SessionItem(
      id: 'en_alphabets',
      category: SessionCategory.english,
      titleKey: 'Alphabets',
      iconName: 'category_en_alphabet',
      onTap: (context) => context.pushNamed(RouteName.englishAlphabet),
    ),
    SessionItem(
      id: 'en_vocabulary',
      category: SessionCategory.english,
      titleKey: 'Vocabulary',
      iconName: 'category_vocabulary',
      onTap: (context) => context.pushNamed(RouteName.englishVocabulary),
    ),
    // SessionItem(
    //   id: 'en_poems',
    //   category: SessionCategory.english,
    //   titleKey: 'poems',
    //   iconName: 'category_poem',
    //   onTap: (context) => context.pushNamed(RouteName.englishPoem),
    // ),
    SessionItem(
      id: 'en_stories',
      category: SessionCategory.english,
      titleKey: 'Stories',
      iconName: 'category_story',
      onTap: (context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  PoemToryListView(
              poemtoryType: 'stories', subject: 'en',
              title: 'Stories',
            ))
        );
      },
    ),
    SessionItem(
      id: 'en_songs',
      category: SessionCategory.english,
      titleKey: 'Songs',
      iconName: 'category_song',
      onTap: (context) => context.pushNamed(RouteName.englishNumber),
    ),
    SessionItem(
      id: 'en_math',
      category: SessionCategory.english,
      titleKey: 'Math',
      iconName: 'category_math',
      onTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MathView(
            learnLanguageType: LearnLanguageType.en.name,
          ),
        ),
      ),
    ),
    // SessionItem(
    //   id: 'en_game',
    //   category: SessionCategory.english,
    //   titleKey: 'game',
    //   iconName: 'playing_game',
    //   onTap: (context) => context.pushNamed(RouteName.englishGame),
    // ),

    // ---- Myanmar (8) ----
    SessionItem(
      id: 'mm_numbers',
      category: SessionCategory.myanmar,
      titleKey: 'နံပါတ်များ',
      iconName: 'category_number',
      onTap: (context) => context.pushNamed(RouteName.myanmarNumber),
    ),
    SessionItem(
      id: 'mm_alphabets',
      category: SessionCategory.myanmar,
      titleKey: 'အက္ခရာများ',
      iconName: 'category_mm_alphabet',
      onTap: (context) => context.pushNamed(RouteName.myanmarAlphabet),
    ),
    SessionItem(
      id: 'mm_vocabulary',
      category: SessionCategory.myanmar,
      titleKey: 'ဝေါဟာရ',
      iconName: 'category_vocabulary',
      onTap: (context) => context.pushNamed(RouteName.myanmarVocabulary),
    ),
    // SessionItem(
    //   id: 'mm_poems',
    //   category: SessionCategory.myanmar,
    //   titleKey: 'ကဗျာများ',
    //   iconName: 'category_poem',
    //   onTap: (context) =>  Navigator.push(context,
    //       MaterialPageRoute(builder: (context) =>  PoemToryListView(
    //         poemtoryType: 'poems', subject: 'mm',
    //         title: 'ကဗျာများ',
    //       ))
    //   ),
    // ),
    SessionItem(
      id: 'mm_stories',
      category: SessionCategory.myanmar,
      titleKey: 'ပုံပြင်များ',
      iconName: 'category_story',
      onTap: (context) =>  Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  PoemToryListView(
            poemtoryType: 'poems', subject: 'mm',
            title: 'ပုံပြင်များ',
          ))
      ),
    ),
    SessionItem(
      id: 'mm_songs',
      category: SessionCategory.myanmar,
      titleKey: 'သီချင်းများ',
      iconName: 'category_song',
      onTap: (context) => Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  PoemToryListView(
            poemtoryType: 'songs', subject: 'mm',
            title: 'သီချင်းများ',
          ))
      ),
    ),
    SessionItem(
      id: 'mm_math',
      category: SessionCategory.myanmar,
      titleKey: 'သင်္ချာ',
      iconName: 'category_math',
      onTap: (context) => Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  MathView(
            learnLanguageType: 'mm',
          ))
      ),
    )
  ];
}
