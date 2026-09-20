// Path: features/topics/data/model/vocab_category_model.dart
class VocabCategoryModel {
  int? id;
  String? name;
  String? nameMm;

  VocabCategoryModel({this.id, this.name, this.nameMm});

  VocabCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameMm = json['name_mm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_mm'] = nameMm;
    return data;
  }
}
