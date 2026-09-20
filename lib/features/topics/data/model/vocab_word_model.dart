import '../../../../app/model/paginate_ob.dart';

class VocabWordModel {
  List<VocabWordData>? data;
  Links? links;
  Meta? meta;

  VocabWordModel({this.data, this.links, this.meta});

  VocabWordModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VocabWordData>[];
      json['data'].forEach((v) {
        data!.add(new VocabWordData.fromJson(v));
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

class VocabWordData {
  int? id;
  String? categoryName;
  String? word;
  dynamic phonetic;
  String? image;
  String? audio;

  VocabWordData(
      {this.id,
        this.categoryName,
        this.word,
        this.phonetic,
        this.image,
        this.audio});

  VocabWordData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    word = json['word'];
    phonetic = json['phonetic'];
    image = json['image'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['word'] = this.word;
    data['phonetic'] = this.phonetic;
    data['image'] = this.image;
    data['audio'] = this.audio;
    return data;
  }
}