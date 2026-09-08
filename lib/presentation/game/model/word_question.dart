// Path: model/word_question.dart

/// A single Word Sorting Game question, shaped after the
/// `GET /api/v1/games/word-sorting` response. Only raw content lives here —
/// letter shuffling, hint copy and validation are client-side concerns
/// handled by [WordSortGameController].
class WordQuestion {
  final String id;
  final String word;
  final String imageUrl;
  final String audioUrl;

  const WordQuestion({
    required this.id,
    required this.word,
    required this.imageUrl,
    required this.audioUrl,
  });

  factory WordQuestion.fromJson(Map<String, dynamic> json) {
    return WordQuestion(
      id: json['id'] as String,
      word: (json['word'] as String).toUpperCase(),
      imageUrl: json['image_url'] as String,
      audioUrl: json['audio_url'] as String,
    );
  }

  static List<WordQuestion> listFromJson(List<dynamic> json) =>
      json.map((e) => WordQuestion.fromJson(e as Map<String, dynamic>)).toList();
}
