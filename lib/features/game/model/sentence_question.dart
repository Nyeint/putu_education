// Path: model/sentence_question.dart

/// A single Sentence Sorting Game question, shaped after the
/// `GET /api/v1/games/sentence-sorting` response. Only raw content lives
/// here — word shuffling, blank copy and validation are client-side
/// concerns handled by [SentenceSortGameController].
class SentenceQuestion {
  final String id;
  final List<String> words;
  final String imageUrl;

  const SentenceQuestion({
    required this.id,
    required this.words,
    required this.imageUrl,
  });

  String get sentence => words.join(' ');

  factory SentenceQuestion.fromJson(Map<String, dynamic> json) {
    return SentenceQuestion(
      id: json['id'] as String,
      words: (json['words'] as List).map((e) => e as String).toList(),
      imageUrl: json['image_url'] as String,
    );
  }

  static List<SentenceQuestion> listFromJson(List<dynamic> json) =>
      json.map((e) => SentenceQuestion.fromJson(e as Map<String, dynamic>)).toList();
}
