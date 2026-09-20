// Path: features/topics/domain/repositories/vocab_repo.dart
import '../../../../data/model/response_ob.dart';

abstract class VocabRepo {
  /// Subject to a 5 minute cache: a call within 5 minutes of the last one
  /// that returned data is served from cache instead of hitting the network,
  /// unless [forceRefresh] is set (pull-to-refresh) or the cached result had
  /// no data, in which case the cache is bypassed and the network is always
  /// called.
  Future<ResponseOb> getCategories({bool forceRefresh = false});

  /// [subject] is the API's language code for the vocabulary set: 'en' for
  /// English, 'my' for Myanmar. [category] is the category's name (e.g.
  /// 'fruit'); omit it to request every category ("All" tab).
  ///
  /// Subject to the same 5 minute cache rule as [getCategories], keyed per
  /// [subject]/[category] combination.
  Future<ResponseOb> getVocabulary({
    required String subject,
    String? category,
    bool forceRefresh = false,
  });
}
