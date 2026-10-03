// Path: features/topics/data/repositories/alphabet_repo_impl.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/alphabet_repo.dart';

class AlphabetRepoImpl implements AlphabetRepo {
  final DioBaseNetwork network;

  AlphabetRepoImpl(this.network);

  static const Duration _cacheTtl = Duration(seconds: 10);

  String _cacheKey(String subject, int page) =>
      'alphabets_cache_${subject}_$page';

  @override
  Future<ResponseOb> getAlphabets({
    required String subject,
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final cacheKey = _cacheKey(subject, page);

    if (!forceRefresh) {
      final cached = await _readCache(cacheKey);
      if (cached != null) {
        return ResponseOb(message: MsgState.data, data: cached);
      }
    }

    final response = await _requestFromNetwork(subject, page);

    if (response.message == MsgState.data) {
      await _writeCache(cacheKey, response.data);
    }

    return response;
  }

  Future<ResponseOb> _requestFromNetwork(String subject, int page) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'lessons/alphabets',
      params: {'subject': subject, 'page': page},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  /// Returns the cached response body for [cacheKey], or null if there is no
  /// cache, the cache is stale (older than 10 seconds), or the cached result
  /// had no data - in every one of those cases the caller should hit the
  /// network.
  Future<dynamic> _readCache(String cacheKey) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(cacheKey);
    final cachedAtMillis = prefs.getInt('${cacheKey}_ts');
    if (raw == null || cachedAtMillis == null) return null;

    dynamic json;
    try {
      json = jsonDecode(raw);
    } catch (_) {
      return null;
    }

    final list = json is Map ? json['data'] : null;
    final hasData = list is List && list.isNotEmpty;
    if (!hasData) return null; // no data -> ignore the 10 second rule, refetch

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMillis);
    final isFresh = DateTime.now().difference(cachedAt) < _cacheTtl;
    if (!isFresh) return null;

    return json;
  }

  Future<void> _writeCache(String cacheKey, dynamic data) async {
    if (data is! Map) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(data));
    await prefs.setInt('${cacheKey}_ts', DateTime.now().millisecondsSinceEpoch);
  }
}
