import '../../../data/model/response_ob.dart';

abstract class CheckUpdateRepo {
  Future<ResponseOb> checkVersion({
    required String platform,
    required String version,
    required String buildNumber,
  });
}
