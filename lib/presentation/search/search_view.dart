// Path: search/search_view.dart
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/presentation/math/shape/shape_view.dart';
import 'package:putu_education/presentation/widgets/my_appbar.dart';
import 'package:putu_education/presentation/widgets/my_icon.dart';
import 'package:putu_education/route/my_router.dart';

import 'search_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  SearchTabType? _selectedTab;

  // Loaded so search matches a query regardless of which language it's typed in,
  // independent of the app's currently active display locale.
  Map<String, dynamic> _enStrings = {};
  Map<String, dynamic> _mmStrings = {};

  @override
  void initState() {
    super.initState();
    _loadSearchLocales();
  }

  Future<void> _loadSearchLocales() async {
    final results = await Future.wait([
      rootBundle.loadString('languages/en-US.json'),
      rootBundle.loadString('languages/my-MM.json'),
    ]);
    if (!mounted) return;
    setState(() {
      _enStrings = jsonDecode(results[0]) as Map<String, dynamic>;
      _mmStrings = jsonDecode(results[1]) as Map<String, dynamic>;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _displayTitle(SearchItem item) => item.titleKeys.map((key) => tr(key)).join(' ');

  String _searchText(SearchItem item) {
    final en = item.titleKeys.map((key) => _enStrings[key]?.toString() ?? key).join(' ');
    final mm = item.titleKeys.map((key) => _mmStrings[key]?.toString() ?? key).join(' ');
    return '$en $mm'.toLowerCase();
  }

  void _clearQuery() {
    _controller.clear();
    setState(() {
      _query = '';
      _selectedTab = null;
    });
  }

  Color _darken(Color color, [double amount = 0.12]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  // At least 3 cards per row on phones, at least 5 per row on iPad-size screens.
  static const double _tabletBreakpoint = 600;

  int _gridColumns(BuildContext context) => context.width >= _tabletBreakpoint ? 5 : 3;

  double _gridItemWidth(BuildContext context, {double spacing = 16, double horizontalPadding = 32}) {
    final columns = _gridColumns(context);
    final available = context.width - horizontalPadding - spacing * (columns - 1);
    return available / columns;
  }

  List<SearchTopic> _topics(BuildContext context) => [
    SearchTopic(
      titleKey: 'vocabulary',
      iconAsset: 'assets/images/category_vocabulary.png',
      background: const Color(0xffFFE1E6),
      foreground: ColorResources.animal,
      onTap: () => context.pushNamed(RouteName.englishVocabulary),
    ),
    SearchTopic(
      titleKey: 'numbers',
      iconAsset: 'assets/images/category_number.png',
      background: const Color(0xffDFF5E3),
      foreground: ColorResources.math,
      onTap: () => context.pushNamed(RouteName.englishNumber),
    ),
    SearchTopic(
      titleKey: 'songs',
      iconAsset: 'assets/images/category_song.png',
      background: const Color(0xffF8D8C0),
      foreground: ColorResources.color,
      onTap: () => context.pushNamed(RouteName.englishPoem),
    ),
    SearchTopic(
      titleKey: 'stories',
      iconAsset: 'assets/images/category_story.png',
      background: const Color(0xffFCEFCE),
      foreground: Colors.deepOrange,
      onTap: () => context.pushNamed(RouteName.englishPoem),
    ),
    SearchTopic(
      titleKey: 'alphabets',
      iconAsset: 'assets/images/category_en_alphabet.png',
      background: const Color(0xffDFEEFB),
      foreground: ColorResources.fruit_veg,
      onTap: () => context.pushNamed(RouteName.englishAlphabet),
    ),
    SearchTopic(
      titleKey: 'poems',
      iconAsset: 'assets/images/category_poem.png',
      background: const Color(0xffEEE3FB),
      foreground: ColorResources.story_poem,
      onTap: () => context.pushNamed(RouteName.englishPoem),
    ),

  ];

  List<SearchItem> _allItems(BuildContext context) => [
        SearchItem(
          titleKeys: const ['vocabulary'],
          categoryKey: 'vocabulary',
          type: SearchTabType.vocabulary,
          iconAsset: 'assets/images/category_vocabulary.png',
          badgeColor: ColorResources.animal,
          onTap: () => context.pushNamed(RouteName.englishVocabulary),
        ),
        SearchItem(
          titleKeys: const ['alphabets'],
          categoryKey: 'alphabets',
          type: SearchTabType.other,
          iconAsset: 'assets/images/category_en_alphabet.png',
          badgeColor: ColorResources.color,
          onTap: () => context.pushNamed(RouteName.englishAlphabet),
        ),
        SearchItem(
          titleKeys: const ['numbers'],
          categoryKey: 'numbers',
          type: SearchTabType.other,
          iconAsset: 'assets/images/category_number.png',
          badgeColor: ColorResources.math,
          onTap: () => context.pushNamed(RouteName.englishNumber),
        ),
        SearchItem(
          titleKeys: const ['poems'],
          categoryKey: 'poems',
          type: SearchTabType.poem,
          iconAsset: 'assets/images/category_poem.png',
          badgeColor: ColorResources.story_poem,
          onTap: () => context.pushNamed(RouteName.englishPoem),
        ),
        SearchItem(
          titleKeys: const ['alphabets'],
          categoryKey: 'alphabets',
          type: SearchTabType.other,
          iconAsset: 'assets/images/category_mm_alphabet.png',
          badgeColor: ColorResources.color,
          onTap: () => context.pushNamed(RouteName.myanmarAlphabet),
        ),
        SearchItem(
          titleKeys: const ['numbers'],
          categoryKey: 'numbers',
          type: SearchTabType.other,
          iconAsset: 'assets/images/mm_number.png',
          badgeColor: ColorResources.math,
          onTap: () => context.pushNamed(RouteName.myanmarNumber),
        ),
        SearchItem(
          titleKeys: const ['shapes'],
          categoryKey: 'math',
          type: SearchTabType.other,
          iconAsset: 'assets/images/shape.png',
          badgeColor: ColorResources.fruit_veg,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ShapeView(locale: 'en')),
          ),
        ),
        SearchItem(
          titleKeys: const ['calculation'],
          categoryKey: 'math',
          type: SearchTabType.other,
          iconAsset: 'assets/images/calculation.png',
          badgeColor: ColorResources.fruit_veg,
          onTap: () => context.pushNamed(RouteName.calculation),
        ),
        SearchItem(
          titleKeys: const ['word', 'game'],
          categoryKey: 'game',
          type: SearchTabType.game,
          iconAsset: 'assets/images/english_word.png',
          badgeColor: ColorResources.english,
          onTap: () => context.pushNamed(RouteName.englishWordGame),
        ),
        SearchItem(
          titleKeys: const ['word_sort', 'game'],
          categoryKey: 'game',
          type: SearchTabType.game,
          iconAsset: 'assets/images/english_word_sort.png',
          badgeColor: ColorResources.english,
          onTap: () => context.pushNamed(RouteName.englishWordSortGame),
        ),
        SearchItem(
          titleKeys: const ['sentence_sort', 'game'],
          categoryKey: 'game',
          type: SearchTabType.game,
          iconAsset: 'assets/images/english_sentence.png',
          badgeColor: ColorResources.english,
          onTap: () => context.pushNamed(RouteName.englishSentenceSortGame),
        ),
        SearchItem(
          titleKeys: const ['counting', 'game'],
          categoryKey: 'game',
          type: SearchTabType.game,
          iconAsset: 'assets/images/math_count.png',
          badgeColor: ColorResources.english,
          onTap: () => context.pushNamed(RouteName.mathCountingGame),
        ),
        SearchItem(
          titleKeys: const ['calculate', 'game'],
          categoryKey: 'game',
          type: SearchTabType.game,
          iconAsset: 'assets/images/math_calculate.png',
          badgeColor: ColorResources.english,
          onTap: () => context.pushNamed(RouteName.mathCalculateGame),
        ),
      ];

  List<SearchItem> _filteredItems(BuildContext context) {
    final query = _query.toLowerCase();
    return _allItems(context).where((item) {
      final matchesTab = _selectedTab == null || item.type == _selectedTab;
      final matchesQuery = query.isEmpty || _searchText(item).contains(query);
      return matchesTab && matchesQuery;
    }).toList();
  }

  Widget _searchIconBadge() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.primaryGradient.withOpacity(0.5)),
      child: SvgPicture.asset('assets/icons/search.svg', height: 14),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: MyIcon(iconName: 'back'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: ColorResources.secondary,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: _darken(ColorResources.secondary, 0.2), offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                _searchIconBadge(),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) => setState(() => _query = value.trim()),
                    style: FontFamily().medium.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      filled: false,
                      border: InputBorder.none,
                      hintText: tr('search_hint'),
                      hintStyle: FontFamily().medium.copyWith(fontSize: 16, color: ColorResources.subText),
                    ),
                  ),
                ),
                if (_query.isNotEmpty)
                  GestureDetector(
                    onTap: _clearQuery,
                    child: SvgPicture.asset('assets/icons/close.svg', height: 14),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _topicCard(BuildContext context, SearchTopic topic) {
    final width = _gridItemWidth(context, spacing: 16);
    final iconSize = (width * 0.6).clamp(36.0, 70.0);
    final fontSize = (width * 0.14).clamp(11.0, 17.0);
    return GestureDetector(
      onTap: topic.onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: topic.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(color: _darken(topic.background, 0.15), offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              padding: EdgeInsets.all(1),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(iconSize / 2),
                child: Image.asset(
                    topic.iconAsset,
                    fit: BoxFit.fitHeight),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              tr(topic.titleKey),
              style: FontFamily().bold.copyWith(color: topic.foreground, fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultState(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('top_explored_topics'), style: FontFamily().semiBold.copyWith(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _topics(context).map((topic) => _topicCard(context, topic)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, SearchTabType? type) {
    final selected = _selectedTab == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = type),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? ColorResources.primary : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: selected ? null : Border.all(color: ColorResources.stroke.withOpacity(0.5), width: 1.2),
        ),
        child: Text(
          label,
          style: FontFamily().medium.copyWith(
              fontSize: 14, color: selected ? ColorResources.textPrimary : ColorResources.itemSecondary),
        ),
      ),
    );
  }

  Widget _resultCard(BuildContext context, SearchItem item) {
    final width = _gridItemWidth(context, spacing: 12);
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              spreadRadius: 0.5,
              offset: const Offset(0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(20),
                      //   topRight: Radius.circular(20),
                      // ),
                      child: Image.asset(item.iconAsset, fit: BoxFit.contain)
                      // Container(
                      //   height: 90,
                      //   width: double.infinity,
                      //   color: item.badgeColor.withOpacity(0.15),
                      //   padding: const EdgeInsets.all(18),
                      //   child: Image.asset(item.iconAsset, fit: BoxFit.contain),
                      // ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: item.badgeColor, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      tr(item.categoryKey),
                      style: FontFamily().medium.copyWith(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  _displayTitle(item),
                  style: FontFamily().semiBold.copyWith(fontSize: 14),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultsState(BuildContext context, List<SearchItem> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _tab(tr('all'), null),
              const SizedBox(width: 10),
              _tab(tr('vocabulary'), SearchTabType.vocabulary),
              const SizedBox(width: 10),
              _tab(tr('games'), SearchTabType.game),
              const SizedBox(width: 10),
              _tab(tr('poems'), SearchTabType.poem),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: results.isEmpty
              ? _emptyResultState(context)
              : SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: results.map((item) => _resultCard(context, item)).toList(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _emptyResultState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_message.png', width: 160),
          const SizedBox(height: 24),
          Text(
            tr('no_result_title'),
            style: FontFamily().bold.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            tr('no_result_desc'),
            style: FontFamily().regular.copyWith(color: ColorResources.subText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: _clearQuery,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[ColorResources.primary, ColorResources.primaryGradient]),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 2.0, spreadRadius: 0.5, offset: const Offset(0, 2.0)),
                ],
              ),
              child: Text(tr('go_back'), style: FontFamily().semiBold.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty ? <SearchItem>[] : _filteredItems(context);

    return Scaffold(
      backgroundColor: ColorResources.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/background.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            MyAppBar(widget: _header(context)),
            Expanded(
              child: (_query.isEmpty ? _defaultState(context) : _resultsState(context, results))
                  .pad(left: 16, right: 16, top: 20, bottom: MediaQuery.of(context).padding.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
