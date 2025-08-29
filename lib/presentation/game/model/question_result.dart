class QuestionResultModel {
  dynamic question;
  dynamic result;

  QuestionResultModel({this.question, this.result});

  QuestionResultModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['result'] = this.result;
    return data;
  }
}
