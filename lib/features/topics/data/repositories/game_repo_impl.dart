// Path: features/topics/data/repositories/game_repo_impl.dart
import 'dart:async';

import '../../../../app/config/api_constants.dart';
import '../../../../data/model/response_ob.dart';
import '../../../../network/dio_basenetwork.dart';
import '../../domain/repositories/game_repo.dart';

class GameRepoImpl implements GameRepo {
  final DioBaseNetwork network;

  GameRepoImpl(this.network);

  @override
  Future<ResponseOb> getChoosePictureGame({required String subject}) {
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
  Future<ResponseOb> getWordSortingGame({required String subject}) {
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
  Future<ResponseOb> getSentenceSortingGame({required String subject}) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'games/sentence-sorting',
      params: {'subject': subject},
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }
}
