import '../model_factory.dart';

class PnObClass<T extends Object?, P extends Object?> {
  List<T?>? data;
  Links? links;
  Meta? meta;
  dynamic result;
  String? message;
  String? pageImage;

  PnObClass({this.data, this.links, this.meta, this.result, this.message, this.pageImage});

  PnObClass.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <T>[];
      json['data'].forEach((v) {
        data!.add(objectFactories[T]!(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    // print("LOOOKK JSOSNSL ${json['result']} and ${json.toString()}");
    // if (json['result'] != null) {
    //   // data = <T>[];
    //   // json['result'].forEach((v) {
    //   //   data!.add(objectFactories[T]!(v));
    //   // });
    //   result = json['result'];
    // }
    // result = json['result'] != null ? new Links.fromJson(json['links']) : null;
    // result = new ArtistData.fromJson(json['result']);
    message = json['message'];
    pageImage = json['page_image'].toString();
    // if(json['result'] != null ){
    //   if(P.toString().replaceAll('?', '')=='ArtistData'){
    //     result = new ArtistData.fromJson(json['result']);
    //   }else if(P.toString().replaceAll('?', '')=='AlbumData'){
    //     result = new AlbumData.fromJson(json['result']);
    //   }
    // }
  }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  String? total;

  Meta({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

// class Result {
//   int? id;
//   String? name;
//   String? photo;
//   String? createdAt;
//   String? updatedAt;
//   int? year;
//   ArtistData? artist;
//
//
//   Result(
//       {this.id, this.name, this.photo, this.createdAt, this.updatedAt, this.year, this.artist});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     photo = json['photo'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     year = json['year'];
//     json['artist'] != null ? new ArtistData.fromJson(json['artist']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['photo'] = this.photo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['year'] = this.year;
//     if (this.artist != null) {
//       data['artist'] = this.artist!.toJson();
//     }
//     return data;
//   }
// }
