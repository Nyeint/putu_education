// Path: features/topics/data/repositories/poemtory_repo_impl.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/poemtory_repo.dart';

class PoemToryRepoImpl implements PoemToryRepo {
  final DioBaseNetwork network;

  PoemToryRepoImpl(this.network);

  static const Duration _cacheTtl = Duration(minutes: 10);

  String _cacheKey(String poemtoryType, String subject) =>
      'poemtory_cache_${poemtoryType}_$subject';

  String _cacheTimestampKey(String poemtoryType, String subject) =>
      'poemtory_cache_ts_${poemtoryType}_$subject';

  @override
  Future<ResponseOb> getPoemTories({
    required String poemtoryType,
    required String subject,
    int page = 1,
    bool forceRefresh = false,
  }) async {
    // Caching/throttling only applies to the first page - "load more" pages
    // always go straight to the network.
    if (page == 1 && !forceRefresh) {
      final cached = await _readCache(poemtoryType, subject);
      if (cached != null) {
        return ResponseOb(message: MsgState.data, data: cached);
      }
    }

    final response = await _requestFromNetwork(poemtoryType, subject, page);

    if (page == 1 && response.message == MsgState.data) {
      await _writeCache(poemtoryType, subject, response.data);
    }

    return response;
  }

  Future<ResponseOb> _requestFromNetwork(String poemtoryType, String subject, int page) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'lessons/poemtorys/$poemtoryType',
      params: {'subject': subject, 'page': page},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  /// Returns the cached page-1 response body, or null if there is no cache,
  /// the cache is stale (older than 10 minutes), or the cached result had no
  /// data - in every one of those cases the caller should hit the network.
  Future<Map<String, dynamic>?> _readCache(String poemtoryType, String subject) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey(poemtoryType, subject));
    final cachedAtMillis = prefs.getInt(_cacheTimestampKey(poemtoryType, subject));
    if (raw == null || cachedAtMillis == null) return null;

    Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }

    final list = json['data'];
    final hasData = list is List && list.isNotEmpty;
    if (!hasData) return null; // no data -> ignore the 5 min rule, refetch

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMillis);
    final isFresh = DateTime.now().difference(cachedAt) < _cacheTtl;
    if (!isFresh) return null;

    return json;
  }

  Future<void> _writeCache(String poemtoryType, String subject, dynamic data) async {
    if (data is! Map<String, dynamic>) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey(poemtoryType, subject), jsonEncode(data));
    await prefs.setInt(
      _cacheTimestampKey(poemtoryType, subject),
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
