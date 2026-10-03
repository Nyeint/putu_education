// Path: features/topics/data/repositories/vocab_repo_impl.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/vocab_repo.dart';

class VocabRepoImpl implements VocabRepo {
  final DioBaseNetwork network;

  VocabRepoImpl(this.network);

  static const Duration _cacheTtl = Duration(minutes: 5);
  static const String _categoriesCacheKey = 'vocab_categories_cache';

  String _vocabularyCacheKey(String subject, String? category) =>
      'vocab_words_cache_${subject}_${category ?? 'all'}';

  @override
  Future<ResponseOb> getCategories({bool forceRefresh = false}) {
    return _cachedRequest(
      cacheKey: _categoriesCacheKey,
      forceRefresh: forceRefresh,
      request: _requestCategoriesFromNetwork,
    );
  }

  @override
  Future<ResponseOb> getVocabulary({
    required String subject,
    String? category,
    int page = 1,
    bool forceRefresh = false,
  }) {
    // Caching/throttling only applies to the first page - "load more" pages
    // always go straight to the network.
    if (page != 1) {
      return _requestVocabularyFromNetwork(subject, category, page);
    }
    return _cachedRequest(
      cacheKey: _vocabularyCacheKey(subject, category),
      forceRefresh: forceRefresh,
      request: () => _requestVocabularyFromNetwork(subject, category, page),
    );
  }

  /// Serves [cacheKey] from cache when it's fresh (< 5 minutes old) and
  /// non-empty; otherwise calls [request] and, on success, refreshes the
  /// cache with the new result.
  Future<ResponseOb> _cachedRequest({
    required String cacheKey,
    required bool forceRefresh,
    required Future<ResponseOb> Function() request,
  }) async {
    if (!forceRefresh) {
      final cached = await _readCache(cacheKey);
      if (cached != null) {
        return ResponseOb(message: MsgState.data, data: cached);
      }
    }

    final response = await request();

    if (response.message == MsgState.data) {
      await _writeCache(cacheKey, response.data);
    }

    return response;
  }

  Future<ResponseOb> _requestCategoriesFromNetwork() {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'categories',
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  Future<ResponseOb> _requestVocabularyFromNetwork(
      String subject, String? category, int page) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'lessons/vocabulary',
      params: {
        'subject': subject,
        if (category != null) 'category': category,
        'page': page,
      },
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  /// Returns the cached response body for [cacheKey], or null if there is no
  /// cache, the cache is stale (older than 5 minutes), or the cached result
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

    if (!_hasData(json))
      return null; // no data -> ignore the 5 min rule, refetch

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(cachedAtMillis);
    final isFresh = DateTime.now().difference(cachedAt) < _cacheTtl;
    if (!isFresh) return null;

    return json;
  }

  /// A response body may either be a raw list (categories) or a map with a
  /// 'data'/'result' list (vocabulary, and categories on some backends).
  bool _hasData(dynamic json) {
    if (json is List) return json.isNotEmpty;
    if (json is Map) {
      final inner = json['data'] ?? json['result'];
      if (inner is List) return inner.isNotEmpty;
    }
    return false;
  }

  Future<void> _writeCache(String cacheKey, dynamic data) async {
    if (data is! Map && data is! List) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(data));
    await prefs.setInt('${cacheKey}_ts', DateTime.now().millisecondsSinceEpoch);
  }
}
