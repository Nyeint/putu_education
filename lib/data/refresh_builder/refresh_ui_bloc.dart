import 'package:rxdart/rxdart.dart';
import '../../app/config/api_constants.dart';
import '../../network/dio_basenetwork.dart';
import '../model/pn_ob_class.dart';
import '../model/response_ob.dart';

class RefreshUiBloc<T extends Object?,P extends Object?> extends DioBaseNetwork {
  PublishSubject<ResponseOb> publishSubject = PublishSubject();

  Stream<ResponseOb> streamData() => publishSubject.stream;

  String nextPageUrl = "";
  dynamic responseObData;

  void getData(String url,
      {Map<String, dynamic>? map,
        ReqType? requestType = ReqType.Get,
      bool requestShowLoading = true,
      bool? isCached,
      bool isBaseUrl = true}) async {
    ResponseOb resp = ResponseOb(data: null, message: MsgState.loading);
    // publishSubject.sink.add(resp);
    if (requestShowLoading) {
      publishSubject.sink.add(resp);
    }

    dioReq(requestType, url: isBaseUrl ? BASE_URL + url : url, params: map, isCached: isCached,
        callBack: (ResponseOb rv) {

      if (rv.message == MsgState.data) {
        print("HELLO LOKK here ${rv.data}");

        // T? ob = objectFactories[T]!(rv.data);
        // print('jfkdsjf 1');
        // print('jfkdsjf 1 ${ob} ${rv.links}');
        PnObClass<T,P> flv = PnObClass.fromJson(rv.data);
        // if(rv.data['result']!=null){
        //   // print("AND THEN fl  ${flv.data}");
        //   // print("result issss ${rv.data['result']} and then ${flv.result}");
        //   // MusicObClass rr = MusicObClass.fromJson(flv.result);
        //   print("FNDSKFJ fl is ${flv.result}");
        //   resp.result = flv.result;
        // }
        resp.result = flv.result;

        nextPageUrl = flv.links!.next.toString();
        resp.message = MsgState.data;
        resp.pgState = PageState.first;
        resp.meta = flv!.meta;
        resp.data = flv.data;
        responseObData = flv.result;
        // responseObData=rv.data;
        // resp.result = PnObClass.fromJson(flv.result);
        publishSubject.sink.add(resp);
      }
      //   if (rv.data["result"].toString() == "1") {
      //     T? ob = objectFactories[T]!(rv.data);
      //     // PnObClass<T> flv = PnObClass.fromJson(rv.data);
      //     nextPageUrl = rv.links!.next.toString();
      //     // nextPageUrl = flv.links!.next.toString();
      //     resp.message = MsgState.data;
      //     resp.pgState = PageState.first;
      //     resp.meta = rv.meta;
      //     resp.data = ob;
      //     publishSubject.sink.add(resp);
      //   } else if (rv.data['result'].toString() == "0") {
      //     resp.message = MsgState.more;
      //     resp.data = rv.data;
      //     publishSubject.sink.add(resp);
      //   } else {
      //     publishSubject.sink.add(rv);
      //   }
      // } else {
      //   publishSubject.sink.add(rv);
      // }
    });
  }

  void getLoad(String? url, Map<String, dynamic>? map,
      {ReqType requestType = ReqType.Get, bool? isCached}) async {
    ResponseOb resp = ResponseOb(data: null, message: MsgState.loading);

    print("NExt page url isss 456 $nextPageUrl and ${responseObData} ");
    if (nextPageUrl != "null" && nextPageUrl != "") {
      dioReq(requestType, url: nextPageUrl, params: map, isCached: isCached, callBack: (ResponseOb rv) {

        if (rv.message == MsgState.data) {
          PnObClass<T,P> flv = PnObClass.fromJson(rv.data);
          nextPageUrl = flv.links!.next.toString();
          resp.message = MsgState.data;
          resp.pgState = PageState.other;
          resp.meta = flv!.meta;
          resp.data = flv.data;
          resp.result = flv.result;
          //store for no data next time, if no data, i want to show result data of refresh builder
          responseObData = flv.result;
          print("HERER LOOKKKKKK ${flv.links!.next.toString()} then $responseObData and ${flv.result}");
          publishSubject.sink.add(resp);


          // if (rv.data["result"].toString() == "1") {
          //   // PnObClass<T> flv = PnObClass.fromJson(rv.data);
          //   // T? ob = objectFactories[T]!(rv.data); //
          //   // nextPageUrl = flv.links!.next.toString();
          //   nextPageUrl = rv.links!.next.toString();
          //   resp.message = MsgState.data;
          //   resp.pgState = PageState.other;
          //   resp.data = rv.data;
          //   resp.meta = rv.meta;
          //   publishSubject.sink.add(resp);
          // } else if (rv.data['result'].toString() == "0") {
          //   resp.message = MsgState.more;
          //   resp.data = rv.data;
          //   publishSubject.sink.add(resp);
          // } else {
          //   publishSubject.sink.add(rv);
          // }


        } else {
          print("GO to else stage");
          publishSubject.sink.add(rv);
        }
      });
    } else {
      print("LOOKKKK no moereee");
      List<T> l = [];
      resp.message = MsgState.data;
      resp.data = l;
      resp.pgState = PageState.no_more;
      if(responseObData!=null){
        resp.result = responseObData;
      }
      publishSubject.sink.add(resp);
    }
  }

  void dispose() {
    publishSubject.close();
  }
}
