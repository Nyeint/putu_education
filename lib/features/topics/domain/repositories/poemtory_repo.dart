// Path: features/topics/domain/repositories/poemtory_repo.dart
import '../../../../data/model/response_ob.dart';

abstract class PoemToryRepo {
  /// [poemtoryType] selects the content type (e.g. 'poem', 'story', 'song')
  /// and is sent as part of the API path. [subject] is the API's language
  /// code for the content: 'en' for English, 'my' for Myanmar. [page] is the
  /// 1-based page to request.
  ///
  /// Page 1 is subject to a 5 minute cache: a call within 5 minutes of the
  /// last one that returned data is served from cache instead of hitting the
  /// network, unless [forceRefresh] is set (pull-to-refresh) or the cached
  /// result had no data, in which case the cache is bypassed and the network
  /// is always called.
  Future<ResponseOb> getPoemTories({
    required String poemtoryType,
    required String subject,
    int page = 1,
    bool forceRefresh = false,
  });
}
