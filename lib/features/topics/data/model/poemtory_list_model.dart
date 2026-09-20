import '../../../../app/model/paginate_ob.dart';

class PoemToryListModel {
  List<PoemToryData>? data;
  Links? links;
  Meta? meta;

  PoemToryListModel({this.data, this.links, this.meta});

  PoemToryListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PoemToryData>[];
      json['data'].forEach((v) {
        data!.add(new PoemToryData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class PoemToryData {
  int? id;
  String? title;
  String? image;
  String? brief;
  String? description;
  String? audio;
  int? duration;

  PoemToryData(
      {this.id,
        this.title,
        this.image,
        this.brief,
        this.description,
        this.audio,
        this.duration});

  PoemToryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    brief = json['brief'];
    description = json['description'];
    audio = json['audio'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['brief'] = this.brief;
    data['description'] = this.description;
    data['audio'] = this.audio;
    data['duration'] = this.duration;
    return data;
  }
}