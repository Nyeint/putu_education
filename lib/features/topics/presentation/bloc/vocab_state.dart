// Path: features/topics/presentation/bloc/vocab_state.dart
part of 'vocab_bloc/vocab_bloc.dart';

enum CategoriesStatus { initial, loading, success, failure }

enum VocabularyStatus { initial, loading, success, failure }

/// A single flat state holding both the category tabs and the word list for
/// the currently selected tab, tracked independently. Keeping them on one
/// state (rather than mutually-exclusive Loading/Success/Failure subclasses)
/// means requesting a tab's words never wipes out the already-loaded tabs.
class VocabState extends Equatable {
  final CategoriesStatus categoriesStatus;
  final List<VocabCategoryModel> categories;
  final ResponseOb? categoriesError;

  final VocabularyStatus vocabularyStatus;
  final List<VocabWordData> words;
  final ResponseOb? vocabularyError;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  /// True while a pull-to-refresh (categories + vocabulary together) is in
  /// flight. Kept as a single flag since one pull-to-refresh gesture drives
  /// both requests as one user action.
  final bool isRefreshing;

  const VocabState({
    this.categoriesStatus = CategoriesStatus.initial,
    this.categories = const [],
    this.categoriesError,
    this.vocabularyStatus = VocabularyStatus.initial,
    this.words = const [],
    this.vocabularyError,
    this.currentPage = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  VocabState copyWith({
    CategoriesStatus? categoriesStatus,
    List<VocabCategoryModel>? categories,
    ResponseOb? categoriesError,
    VocabularyStatus? vocabularyStatus,
    List<VocabWordData>? words,
    ResponseOb? vocabularyError,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return VocabState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
      categoriesError: categoriesError ?? this.categoriesError,
      vocabularyStatus: vocabularyStatus ?? this.vocabularyStatus,
      words: words ?? this.words,
      vocabularyError: vocabularyError ?? this.vocabularyError,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        categoriesStatus,
        categories,
        categoriesError,
        vocabularyStatus,
        words,
        vocabularyError,
        currentPage,
        hasMore,
        isLoadingMore,
        isRefreshing,
      ];
}
