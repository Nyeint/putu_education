import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/presentation/dashboard/dashboard.dart';
import 'package:putu_education/presentation/dashboard/language_selection.dart';
import 'package:putu_education/presentation/english/alphabet/alphabet_view.dart';
import 'package:putu_education/presentation/english/number/number_view.dart';
import 'package:putu_education/presentation/english/poem/poem_detail.dart';
import 'package:putu_education/presentation/english/vocabulary/vocabulary_view.dart';
import 'package:putu_education/presentation/game/english/english.dart';
import 'package:putu_education/presentation/game/english/sentence_sort_game.dart';
import 'package:putu_education/presentation/game/english/word_game.dart';
import 'package:putu_education/presentation/game/english/word_sort_game.dart';
import 'package:putu_education/presentation/game/math/calculate_game.dart';
import 'package:putu_education/presentation/game/math/counting_game.dart';
import 'package:putu_education/presentation/game/math/math.dart';
import 'package:putu_education/presentation/game/myanmar/myanmar.dart';
import 'package:putu_education/presentation/game/widgets/result_view.dart';
import 'package:putu_education/presentation/introduction/introduction.dart';
import 'package:putu_education/presentation/math/calculation/calculation_view.dart';
import 'package:putu_education/presentation/math/math_view.dart';
import 'package:putu_education/presentation/math/shape/shape_view.dart';
import 'package:putu_education/presentation/myanmar/number/number_view.dart';
import 'package:putu_education/route/route_name.dart';
import 'package:putu_education/route/route_path.dart';
import '../presentation/english/english_view.dart';
import '../presentation/english/poem/poem_view.dart';
import '../presentation/myanmar/alphabet/alphabet_view.dart';
import '../presentation/myanmar/myanmar_view.dart';

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
        return const EnglishVocabularyView();
      },
    ),
    GoRoute(
      name: RouteName.englishPoem,
      path: RoutePath.englishPoem,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishPoemView();
      },
    ),
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

    GoRoute(
      name: RouteName.poemDetail,
      path: RoutePath.poemDetail,
      builder: (BuildContext context, GoRouterState state) {
        return const PoemDetailView();
      },
    ),
    GoRoute(
      name: RouteName.math,
      path: RoutePath.math,
      builder: (BuildContext context, GoRouterState state) {
        return const MathView();
      },
    ),
    GoRoute(
      name: RouteName.shape,
      path: RoutePath.shape,
      builder: (BuildContext context, GoRouterState state) {
        return const ShapeView();
      },
    ),
    GoRoute(
      name: RouteName.calculation,
      path: RoutePath.calculation,
      builder: (BuildContext context, GoRouterState state) {
        return const CalculationView();
      },
    ),

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
        return const EnglishWordGame();
      },
    ),
    GoRoute(
      name: RouteName.englishWordSortGame,
      path: RoutePath.englishWordSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishWordSortGame();
      },
    ),
    GoRoute(
      name: RouteName.englishSentenceSortGame,
      path: RoutePath.englishSentenceSortGame,
      builder: (BuildContext context, GoRouterState state) {
        return const EnglishSentenceSortGame();
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
  ],
);