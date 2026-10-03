// Path: features/topics/data/model/number_model.dart
import '../../../../app/model/paginate_ob.dart';

class AlphabetListModel {
  List<AlphabetData>? data;
  Links? links;
  Meta? meta;

  AlphabetListModel({this.data, this.links, this.meta});

  AlphabetListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AlphabetData>[];
      json['data'].forEach((v) {
        data!.add(AlphabetData.fromJson(v));
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

class AlphabetData {
  int? id;
  String? letter;
  String? word;
  String? phonetic;
  String? audio;

  AlphabetData({this.id, this.letter, this.word, this.phonetic, this.audio});

  AlphabetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    letter = json['letter'];
    word = json['word'];
    phonetic = json['phonetic'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['letter'] = letter;
    data['word'] = word;
    data['phonetic'] = phonetic;
    data['audio'] = audio;
    return data;
  }
}
