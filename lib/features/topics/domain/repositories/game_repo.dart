// Path: features/topics/domain/repositories/game_repo.dart
import '../../../../data/model/response_ob.dart';

abstract class GameRepo {
  /// [subject] is the API's language code for the game questions: 'en' for
  /// English, 'my' for Myanmar. [forceRefresh] skips the cache and fetches
  /// (and re-caches) a fresh question set.
  Future<ResponseOb> getChoosePictureGame({required String subject, bool forceRefresh = false});

  /// [subject] is the API's language code for the word-sorting questions:
  /// 'en' for English, 'my' for Myanmar. [forceRefresh] skips the cache and
  /// fetches (and re-caches) a fresh question set.
  Future<ResponseOb> getWordSortingGame({required String subject, bool forceRefresh = false});

  /// [subject] is the API's language code for the sentence-sorting
  /// questions: 'en' for English, 'my' for Myanmar. [forceRefresh] skips the
  /// cache and fetches (and re-caches) a fresh question set.
  Future<ResponseOb> getSentenceSortingGame({required String subject, bool forceRefresh = false});

  /// Whether a cached question set exists for this game + subject.
  Future<bool> hasChoosePictureCache({required String subject});
  Future<bool> hasWordSortingCache({required String subject});
  Future<bool> hasSentenceSortingCache({required String subject});
}
