import 'package:putu_education/presentation/game/math/calculate_game.dart';

class CalculateHistoryModel {
  CalculateType? type;
  List<int>? data;
  List<String>? fruit;
  int? result;

  CalculateHistoryModel({this.type, this.data, this.fruit, this.result});

  CalculateHistoryModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
    fruit = json['fruit'].cast<String>();
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    data['fruit'] = this.fruit;
    data['result'] = this.result;
    return data;
  }
}
