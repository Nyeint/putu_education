import 'dart:async';

import '../../../app/config/api_constants.dart';
import '../../../data/model/response_ob.dart';
import '../../../network/dio_basenetwork.dart';
import '../domain/check_update_repo.dart';

class CheckUpdateRepoImpl implements CheckUpdateRepo {
  final DioBaseNetwork network;

  CheckUpdateRepoImpl(this.network);

  @override
  Future<ResponseOb> checkVersion({
    required String platform,
    required String version,
    required String buildNumber,
  }) {
    final completer = Completer<ResponseOb>();
    network.dioReq(
      ReqType.Get,
      url: BASE_URL + 'app/version/check',
      params: {
        'platform': platform,
        'version': version,
        'build_number': buildNumber
      },
      callBack: (ResponseOb ob) => completer.complete(ob),
    );
    return completer.future;
  }
}
