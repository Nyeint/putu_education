// Path: vocabulary/vocabulary_view.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:putu_education/app/config/config.dart';
import 'package:putu_education/app/service/locator.dart';
import 'package:putu_education/app/widgets/loading_widgets.dart';
import 'package:putu_education/features/widgets/item_voice_dialog.dart';
import 'package:putu_education/features/widgets/item_voice_widget.dart';
import '../../../../../app/widgets/banner_ad_widget.dart';
import '../../../../widgets/item_decoration.dart';
import '../../../../widgets/my_appbar.dart';
import '../../bloc/vocab_bloc/vocab_bloc.dart';
import '../../../data/model/vocab_category_model.dart';
import '../../../data/model/vocab_word_model.dart';

/// Shared vocabulary screen for both languages. [subject] is the API's
/// language code for the words being requested ('en' or 'my') and also
/// decides which of a word's labels (English/Myanmar) is shown and spoken.
class VocabularyView extends StatefulWidget {
  final String subject;

  const VocabularyView({super.key, required this.subject});

  @override
  State<VocabularyView> createState() => _VocabularyViewState();
}

class _VocabularyViewState extends State<VocabularyView> {
  final VocabBloc _vocabBloc = getIt<VocabBloc>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// null represents the synthetic "All" tab.
  int? _selectedCategoryId;
  String? _selectedCategoryName;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _vocabBloc.add(const CategoriesRequested());
    _vocabBloc.add(VocabularyRequested(subject: widget.subject));
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _audioPlayer.dispose();
    _vocabBloc.close();
    super.dispose();
  }

  Future<void> _playAudio(String audioUrl) async {
    if (audioUrl.isEmpty) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(audioUrl));
  }

  Future<void> _onRefresh() async {
    _vocabBloc.add(VocabRefreshRequested(
      subject: widget.subject,
      category: _selectedCategoryName,
    ));
    await _vocabBloc.stream.firstWhere((state) => !state.isRefreshing);
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  Future<void> _onLoading() async {
    print("THisijoi fksa;");
    _vocabBloc.add(VocabularyLoadMoreRequested(
      subject: widget.subject,
      category: _selectedCategoryName,
    ));
    await _vocabBloc.stream.firstWhere((state) => !state.isLoadingMore);
    if (_vocabBloc.state.hasMore) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  String _categoryLabel(VocabCategoryModel category, BuildContext context) {
    final isMyanmar = context.locale.languageCode == 'my';
    return (isMyanmar ? category.nameMm : category.name) ?? category.name ?? '';
  }

  // String _wordLabel(VocabWordModel word) {
  //   return (widget.subject == 'my' ? word.nameMm : word.name) ??
  //       word.name ??
  //       word.nameMm ??
  //       '';
  // }

  void _requestVocabulary() {
    _vocabBloc.add(VocabularyRequested(
      subject: widget.subject,
      category: _selectedCategoryName,
    ));
  }

  void _selectCategory(VocabCategoryModel? category) {
    setState(() {
      _selectedCategoryId = category?.id;
      _selectedCategoryName = category?.name?.toLowerCase();
    });
    _requestVocabulary();
    _refreshController.resetNoData();
  }

  Widget _tabItem(
      {required VocabCategoryModel? category, required String label}) {
    final bool isSelected = category?.id == _selectedCategoryId;
    return GestureDetector(
      onTap: () => _selectCategory(category),
      child: Container(
        width: 100,
        height: 40,
        decoration:
            isSelected ? selectedTabDecoration() : unselectedTabDecoration(),
        child: Center(
          child: Text(
            label,
            style: FontFamily().medium.copyWith(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _categoryTabs(VocabState state) {
    if (state.categoriesStatus == CategoriesStatus.loading ||
        state.categoriesStatus == CategoriesStatus.initial) {
      return const Center(child: LoadingWidget(size: 32));
    } else if (state.categoriesStatus == CategoriesStatus.failure) {
      return GestureDetector(
        onTap: () => _vocabBloc.add(const CategoriesRequested()),
        child: Center(
          child: Text(
            'Failed to load categories. Tap to retry.',
            style: FontFamily().medium.copyWith(fontSize: 14),
          ),
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(width: 10),
        _tabItem(category: null, label: tr('all')),
        for (final category in state.categories) ...[
          const SizedBox(width: 10),
          _tabItem(
              category: category, label: _categoryLabel(category, context)),
        ],
      ],
    );
  }

  /// Wraps [child] in a scrollable that always has enough scroll extent to
  /// be dragged, so pull-to-refresh keeps working even while the grid is
  /// loading, empty, or showing a failure message.
  Widget _scrollableMessage(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: constraints.maxHeight,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _vocabularyGrid(VocabState state) {
    if (state.vocabularyStatus == VocabularyStatus.loading ||
        state.vocabularyStatus == VocabularyStatus.initial) {
      return _scrollableMessage(const Center(child: LoadingWidget(size: 32)));
    } else if (state.vocabularyStatus == VocabularyStatus.failure &&
        state.words.isEmpty) {
      return _scrollableMessage(
        GestureDetector(
          onTap: _requestVocabulary,
          child: Center(
            child: Text(
              'Failed to load vocabulary. Tap to retry.',
              style: FontFamily().medium.copyWith(fontSize: 14),
            ),
          ),
        ),
      );
    }

    final words = state.words;
    if (words.isEmpty) {
      return _scrollableMessage(
        Center(
            child: Text(tr('no_data'),
                style: FontFamily().medium.copyWith(fontSize: 14))),
      );
    }

    final photoList = words.map((w) => w.image ?? '').toList();
    // final nameList = words.map(_wordLabel).toList();

    final nameList = words.map((w) => w.word ?? '').toList();
    final audioList = words.map((w) => w.audio ?? '').toList();
    const spacing = 16.0;
    return LayoutBuilder(builder: (context, constraints) {
      // 3 columns on phones, 5 on tablets, 7 on large tablets.
      final available = constraints.maxWidth;
      final columns = available >= 900 ? 7 : (available >= 600 ? 5 : 3);
      final itemWidth = (available - spacing * (columns - 1)) / columns;
      return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: spacing, // gap between adjacent items
          runSpacing: spacing, // gap between lines
          children: List.generate(
            words.length,
            (index) => GestureDetector(
              onTap: () async {
                await _playAudio(audioList[index]);
                showImageDialog(
                  context: context,
                  photoList: photoList,
                  nameList: nameList,
                  audioList: audioList,
                  selectedIndex: index,
                );
              },
              child: ItemVoiceWidget(
                photo: photoList[index],
                name: nameList[index],
                audio: audioList[index],
                width: itemWidth,
              ),
            ),
          ),
        ),
      ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      bottomNavigationBar: const BannerAdWidget(),
      appBar: MyAppBar(
        titleWithGoBack: tr('vocabulary'),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/light_background.png",
                ),
                fit: BoxFit.fill),
          ),
          child: BlocListener<VocabBloc, VocabState>(
            bloc: _vocabBloc,
            // Only fires right as a pull-to-refresh finishes, so it never
            // overlaps with the full-screen retry views shown for a first
            // load failure.
            listenWhen: (previous, current) =>
                previous.isRefreshing && !current.isRefreshing,
            listener: (context, state) {
              final failed =
                  state.categoriesStatus == CategoriesStatus.failure ||
                      state.vocabularyStatus == VocabularyStatus.failure;
              if (failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to load. Please try again.')),
                );
              }
            },
            child: BlocBuilder<VocabBloc, VocabState>(
              bloc: _vocabBloc,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: _categoryTabs(state),
                    ),
                    const SizedBox(height: 24),
                    Flexible(
                      child: SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: state.hasMore,
                        header: WaterDropHeader(),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: _vocabularyGrid(state),
                      ),
                    ),
                  ],
                ).pad(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: MediaQuery.of(context).padding.bottom);
              },
            ),
          ),
        ),
      ),
    );
  }
}
