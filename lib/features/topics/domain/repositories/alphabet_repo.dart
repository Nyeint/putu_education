// Path: features/topics/domain/repositories/alphabet_repo.dart
import '../../../../data/model/response_ob.dart';

abstract class AlphabetRepo {
  /// [subject] is the API's language code for the alphabet set (e.g. 'mm' for
  /// Myanmar). [page] is the 1-based page to request.
  ///
  /// Subject to a 10 second cache keyed per [subject]/[page]: a call within
  /// 10 seconds of the last one that returned data is served from cache
  /// instead of hitting the network, unless [forceRefresh] is set
  /// (pull-to-refresh) or the cached result had no data, in which case the
  /// cache is bypassed and the network is always called.
  Future<ResponseOb> getAlphabets({
    required String subject,
    int page = 1,
    bool forceRefresh = false,
  });
}
