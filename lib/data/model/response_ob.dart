import 'package:putu_education/data/model/pn_ob_class.dart';

class ResponseOb {
  dynamic data;
  Map<String, dynamic>? map;
  MsgState? message;
  ErrState? errState;
  PageState? pgState;
  String? pageName;
  RefreshUIMode mode;
  Meta? meta;
  String? tempId;
  int? success;
  Links? links;
  dynamic result;

  ResponseOb({this.data, this.message, this.pageName, this.pgState, this.errState, this.mode = RefreshUIMode.none, this.meta, this.map,
    this.tempId='', this.success, this.links, this.result});
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'].toString();
    next = json['next'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev.toString();
    data['next'] = next.toString();
    return data;
  }
}

enum MsgState { error, loading, data, more, server, empty_data }
enum ErrState {
  no_internet,
  connection_timeout,
  server_error,
  too_many_request,
  unknown_err,
  validate_err,
  not_supported,
  no_login, //401
  server_maintain,
  not_found
}

enum PageState { first, other, no_more }

enum RefreshUIMode {
  replace,
  edit,
  delete,
  none,
  status,
  add,
  addLocalStorage,
  replaceLocalStorage,
  replaceChatInfoData,
  editLocalStorage,
  replaceEditData,
  replaceFailedData
}
