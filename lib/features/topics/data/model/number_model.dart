// Path: features/topics/data/model/number_model.dart
import '../../../../app/model/paginate_ob.dart';

class NumberListModel {
  List<NumberData>? data;
  Links? links;
  Meta? meta;

  NumberListModel({this.data, this.links, this.meta});

  NumberListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NumberData>[];
      json['data'].forEach((v) {
        data!.add(NumberData.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class NumberData {
  int? id;
  dynamic number;
  String? word;
  String? phonetic;
  String? audio;

  NumberData({this.id, this.number, this.word, this.phonetic, this.audio});

  NumberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    word = json['word'];
    phonetic = json['phonetic'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['word'] = word;
    data['phonetic'] = phonetic;
    data['audio'] = audio;
    return data;
  }
}
