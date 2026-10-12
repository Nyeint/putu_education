// Path: features/topics/data/repositories/number_repo_impl.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/number_repo.dart';

class NumberRepoImpl implements NumberRepo {
  final DioBaseNetwork network;

  NumberRepoImpl(this.network);

  String _cacheKey(String subject, int page) =>
      'numbers_cache_${subject}_$page';

  @override
  Future<ResponseOb> getNumbers({
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
      url: BASE_URL + 'lessons/numbers',
      params: {'subject': subject, 'page': page},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  /// Returns the cached response body for [cacheKey], or null if there is no
  /// cache, or the cached result
  /// had no data - in every one of those cases the caller should hit the
  /// network.
  Future<dynamic> _readCache(String cacheKey) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(cacheKey);
    if (raw == null) return null;

    dynamic json;
    try {
      json = jsonDecode(raw);
    } catch (_) {
      return null;
    }

    final list = json is Map ? json['data'] : null;
    final hasData = list is List && list.isNotEmpty;
    if (!hasData) return null; // no data -> refetch

    return json;
  }

  Future<void> _writeCache(String cacheKey, dynamic data) async {
    if (data is! Map) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(data));
    await prefs.setInt('${cacheKey}_ts', DateTime.now().millisecondsSinceEpoch);
  }
}
