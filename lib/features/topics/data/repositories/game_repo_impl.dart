// Path: features/topics/data/repositories/game_repo_impl.dart
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/game_repo.dart';

class GameRepoImpl implements GameRepo {
  final DioBaseNetwork network;

  GameRepoImpl(this.network);

  @override
  Future<ResponseOb> getChoosePictureGame({required String subject, bool forceRefresh = false}) {
    return _dailyCached('choose-picture', subject, forceRefresh: forceRefresh);
  }

  @override
  Future<bool> hasChoosePictureCache({required String subject}) => _hasCache('choose-picture', subject);

  Future<ResponseOb> _getChoosePictureGameNetwork(String subject) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'games/choose-picture',
      params: {'subject': subject},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  @override
  Future<ResponseOb> getWordSortingGame({required String subject, bool forceRefresh = false}) {
    return _dailyCached('word-sorting', subject, forceRefresh: forceRefresh);
  }

  @override
  Future<bool> hasWordSortingCache({required String subject}) => _hasCache('word-sorting', subject);

  Future<ResponseOb> _getWordSortingGameNetwork(String subject) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'games/word-sorting',
      params: {'subject': subject},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  @override
  Future<ResponseOb> getSentenceSortingGame({required String subject, bool forceRefresh = false}) {
    return _dailyCached('sentence-sorting', subject, forceRefresh: forceRefresh);
  }

  @override
  Future<bool> hasSentenceSortingCache({required String subject}) => _hasCache('sentence-sorting', subject);

  Future<ResponseOb> _getSentenceSortingGameNetwork(String subject) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'games/sentence-sorting',
      params: {'subject': subject},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }

  /// Each game (3 endpoints x 2 subjects = 6) caches only the latest
  /// question set in SharedPreferences, so it survives app restarts /
  /// cleared recents until the next successful fetch overwrites it.
  /// [forceRefresh] skips reading the cache (still overwrites it on success).
  Future<ResponseOb> _dailyCached(String game, String subject, {bool forceRefresh = false}) async {
    final key = 'game_cache_${game}_$subject';
    final prefs = await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final raw = prefs.getString(key);
      if (raw != null) {
        try {
          return ResponseOb(message: MsgState.data, data: jsonDecode(raw));
        } catch (_) {} // corrupt cache -> refetch
      }
    }

    final ob = await switch (game) {
      'choose-picture' => _getChoosePictureGameNetwork(subject),
      'word-sorting' => _getWordSortingGameNetwork(subject),
      _ => _getSentenceSortingGameNetwork(subject),
    };
    final data = ob.data;
    if (ob.message == MsgState.data && (data is Map || data is List)) {
      await prefs.setString(key, jsonEncode(data));
    }
    return ob;
  }

  Future<bool> _hasCache(String game, String subject) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('game_cache_${game}_$subject');
  }
}
