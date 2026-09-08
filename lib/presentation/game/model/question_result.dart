// Path: model/question_result.dart
class QuestionResultModel {
  dynamic question;
  dynamic result;
  dynamic correctAnswer;

  QuestionResultModel({this.question, this.result, this.correctAnswer});

  QuestionResultModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    result = json['result'];
    correctAnswer = json['correctAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['result'] = this.result;
    data['correctAnswer'] = this.correctAnswer;
    return data;
  }
}
