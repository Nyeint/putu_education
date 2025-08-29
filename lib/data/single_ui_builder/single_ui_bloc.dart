import 'package:rxdart/rxdart.dart';

import '../../app/config/api_constants.dart';
import '../../network/dio_basenetwork.dart';
import '../model/response_ob.dart';
import '../model_factory.dart';

class SingleUiBloc<T> extends DioBaseNetwork {
  String url;
  bool isBaseUrl;
  SingleUiBloc(this.url, {this.isBaseUrl = true});
  PublishSubject<ResponseOb> publishSubject = PublishSubject();
  Stream<ResponseOb> shopStream() => publishSubject.stream;

  void getData(
      {Map<String, dynamic>? map,
        ReqType? requestType = ReqType.Get,
        bool requestShowLoading = true,
        bool? isCached}) async {
    ResponseOb resp = ResponseOb(data: null, message: MsgState.loading);
    if (requestShowLoading) {
      publishSubject.sink.add(resp);
    }

    dioReq(requestType, url: isBaseUrl ? BASE_URL + url : url, params: map, isCached: isCached, callBack: (ResponseOb rv) {
      print("LOOKKKKKK  ${rv.data} and ${rv.message} and ${rv.data['result']}");
      if (rv.message == MsgState.data) {
          T? ob = objectFactories[T]!(rv.data); //
          resp.message = MsgState.data;
          resp.data = ob;
          print("seee data ${resp.data}");
          publishSubject.sink.add(resp);
      } else {
        publishSubject.sink.add(rv);
      }
    });
  }

  void dispose() {
    publishSubject.close();
  }
}
