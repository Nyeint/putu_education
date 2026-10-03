// Path: route/route.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/features/dashboard/dashboard.dart';
import 'package:putu_education/features/settings/language_selection.dart';
import 'package:putu_education/features/english/alphabet/alphabet_view.dart';
import 'package:putu_education/features/english/number/number_view.dart';
import 'package:putu_education/features/topics/presentation/pages/games/english.dart';
import 'package:putu_education/features/topics/presentation/pages/games/sentence_sort_game.dart';
import 'package:putu_education/features/topics/presentation/pages/games/word_game.dart';
import 'package:putu_education/features/topics/presentation/pages/games/word_sort_game.dart';
import 'package:putu_education/features/topics/presentation/pages/games/calculate_game.dart';
import 'package:putu_education/features/topics/presentation/pages/games/counting_game.dart';
import 'package:putu_education/features/game/math/math.dart';
import 'package:putu_education/features/topics/presentation/pages/games/myanmar.dart';
import 'package:putu_education/features/topics/presentation/pages/games/mm_word_sort_game.dart';
import 'package:putu_education/features/game/widgets/result_view.dart';
import 'package:putu_education/features/introduction/introduction.dart';
import 'package:putu_education/features/topics/presentation/pages/numbers/burmese_number_view.dart';
import 'package:putu_education/route/route_name.dart';
import 'package:putu_education/route/route_path.dart';
import '../features/english/english_view.dart';
import '../features/topics/presentation/pages/alphabets/burmese_alphabet_view.dart';
import '../features/myanmar/myanmar_view.dart';
import '../features/topics/presentation/pages/math/calculation/calculation_view.dart';
import '../features/topics/presentation/pages/vocabulary_view.dart';

final globalContext =
    router.routerDelegate.navigatorKey.currentContext;

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardView();
        // return PhoneNumberPage();
      },
    ),
    GoRoute(
      name: RouteName.dashboard,
      path: RoutePath.dashboard,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardView();
      },
    ),
    GoRoute(
      name: RouteName.introduction,
      path: RoutePath.introduction,
      builder: (BuildContext context, GoRouterState state) {
        return const IntroductionView();
      },
    ),
    GoRoute(
      name: RouteName.language,
      path: RoutePath.language,
      builder: (BuildContext context, GoRouterState state) {
        return const LanguageSelectionView();
      },
    ),
    GoRoute(
      name: RouteName.englishView,
      path: RoutePath.englishView,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishView();
      },
    ),
    GoRoute(
      name: RouteName.myanmarView,
      path: RoutePath.myanmarView,
      builder: (BuildContext context, GoRouterState state) {
        return const MyanmarView();
      },
    ),
    GoRoute(
      name: RouteName.englishNumber,
      path: RoutePath.englishNumber,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishNumberView();
      },
    ),
    GoRoute(
      name: RouteName.englishAlphabet,
      path: RoutePath.englishAlphabet,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishAlphabetView();
      },
    ),
    GoRoute(
      name: RouteName.englishVocabulary,
      path: RoutePath.englishVocabulary,
      builder: (BuildContext context, GoRouterState state) {
        return const VocabularyView(subject: 'en');
      },
    ),
    GoRoute(
      name: RouteName.myanmarVocabulary,
      path: RoutePath.myanmarVocabulary,
      builder: (BuildContext context, GoRouterState state) {
        return const VocabularyView(subject: 'mm');
      },
    ),
    // GoRoute(
    //   name: RouteName.englishPoem,
    //   path: RoutePath.englishPoem,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const EnglishPoemView();
    //   },
    // ),
    GoRoute(
      name: RouteName.myanmarNumber,
      path: RoutePath.myanmarNumber,
      builder: (BuildContext context, GoRouterState state) {
        return const MyanmarNumberView();
      },
    ),
    GoRoute(
      name: RouteName.myanmarAlphabet,
      path: RoutePath.myanmarAlphabet,
      builder: (BuildContext context, GoRouterState state) {
        return const MyanmarAlphabetView();
      },
    ),

    // GoRoute(
    //   name: RouteName.poemDetail,
    //   path: RoutePath.poemDetail,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const PoemDetailView();
    //   },
    // ),
    // GoRoute(
    //   name: RouteName.math,
    //   path: RoutePath.math,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return MathView(
    //       learnLangaugeType: state.extra as String?,
    //     );
    //   },
    // ),
    // GoRoute(
    //   name: RouteName.shapeViewEn,
    //   path: RoutePath.shapeViewEn,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const ShapeView();
    //   },
    // ),
    // GoRoute(
    //   name: RouteName.shapeViewMm,
    //   path: RoutePath.shapeViewMm,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const ShapeView();
    //   },
    // ),
    // GoRoute(
    //   name: RouteName.calculation,
    //   path: RoutePath.calculation,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const CalculationView();
    //   },
    // ),

    GoRoute(
      name: RouteName.englishGame,
      path: RoutePath.englishGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishGameView();
      },
    ),
    GoRoute(
      name: RouteName.myanmarGame,
      path: RoutePath.myanmarGame,
      builder: (BuildContext context, GoRouterState state) {
        return const MyanmarGameView();
      },
    ),
    GoRoute(
      name: RouteName.mathGame,
      path: RoutePath.mathGame,
      builder: (BuildContext context, GoRouterState state) {
        return const MathGameView();
      },
    ),
    GoRoute(
      name: RouteName.englishWordGame,
      path: RoutePath.englishWordGame,
      builder: (BuildContext context, GoRouterState state) {
        return const WordGame(subject: 'en');
      },
    ),
    GoRoute(
      name: RouteName.englishWordSortGame,
      path: RoutePath.englishWordSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishWordSortGame(subject: 'en');
      },
    ),
    GoRoute(
      name: RouteName.englishSentenceSortGame,
      path: RoutePath.englishSentenceSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishSentenceSortGame(subject: 'en');
      },
    ),
    GoRoute(
      name: RouteName.myanmarWordGame,
      path: RoutePath.myanmarWordGame,
      builder: (BuildContext context, GoRouterState state) {
        return const WordGame(subject: 'mm');
      },
    ),
    GoRoute(
      name: RouteName.myanmarWordSortGame,
      path: RoutePath.myanmarWordSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const BurmeseWordSortGame();
      },
    ),
    GoRoute(
      name: RouteName.myanmarSentenceSortGame,
      path: RoutePath.myanmarSentenceSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishSentenceSortGame(subject: 'mm',);
      },
    ),
    GoRoute(
      name: RouteName.mathCountingGame,
      path: RoutePath.mathCountingGame,
      builder: (BuildContext context, GoRouterState state) {
        return const MathCountingGame();
      },
    ),
    GoRoute(
      name: RouteName.mathCalculateGame,
      path: RoutePath.mathCalculateGame,
      builder: (BuildContext context, GoRouterState state) {
        return const MathCalculationGame();
      },
    ),
    GoRoute(
      name: RouteName.resultView,
      path: RoutePath.resultView,
      builder: (BuildContext context, GoRouterState state) {
        // final data = state.extra! as List<CalculateHistoryModel>;
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        int score = data['score'];
        Widget childWidget = data['childWidget'];
        return ResultView(score: score, childWidget: childWidget,);
      },
    ),
    // GoRoute(
    //   name: RouteName.search,
    //   path: RoutePath.search,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SearchView();
    //   },
    // ),
  ],
);