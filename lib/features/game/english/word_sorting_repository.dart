// Path: english/word_sorting_repository.dart
import 'dart:math';

import '../model/word_question.dart';

/// Data source for the Word Sorting Game.
///
/// Stands in for a real `GET /api/v1/games/word-sorting?limit=&language=`
/// call (see `mocks/word-sorting-api.md`) — same response shape, same
/// `limit`/`language` query params, same randomization contract. Swap the
/// body of [fetchQuestions] for a `dio` call once the backend exists; nothing
/// else in the game needs to change since callers only depend on
/// [WordQuestion].
class WordSortingRepository {
  const WordSortingRepository();

  static const List<Map<String, dynamic>> _mockResponse = [
    {
      'id': 'word_001',
      'word': 'CAT',
      'image_url':
          'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
      'audio_url': 'https://cdn.putueducation.com/audio/en/cat.mp3',
    },
    {
      'id': 'word_002',
      'word': 'SQUIRREL',
      'image_url':
          'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
      'audio_url': 'https://cdn.putueducation.com/audio/en/squirrel.mp3',
    },
    {
      'id': 'word_003',
      'word': 'ZEBRA',
      'image_url':
          'https://images.unsplash.com/photo-1501705388883-4ed8a543392c?q=80&w=1000&auto=format&fit=crop',
      'audio_url': 'https://cdn.putueducation.com/audio/en/zebra.mp3',
    },
    {
      'id': 'word_004',
      'word': 'DOG',
      'image_url': 'https://picsum.photos/seed/word-game-dog/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/dog.mp3',
    },
    {
      'id': 'word_005',
      'word': 'ELEPHANT',
      'image_url': 'https://picsum.photos/seed/word-game-elephant/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/elephant.mp3',
    },
    {
      'id': 'word_006',
      'word': 'LION',
      'image_url': 'https://picsum.photos/seed/word-game-lion/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/lion.mp3',
    },
    {
      'id': 'word_007',
      'word': 'TIGER',
      'image_url': 'https://picsum.photos/seed/word-game-tiger/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/tiger.mp3',
    },
    {
      'id': 'word_008',
      'word': 'MONKEY',
      'image_url': 'https://picsum.photos/seed/word-game-monkey/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/monkey.mp3',
    },
    {
      'id': 'word_009',
      'word': 'RABBIT',
      'image_url': 'https://picsum.photos/seed/word-game-rabbit/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/rabbit.mp3',
    },
    {
      'id': 'word_010',
      'word': 'BEAR',
      'image_url': 'https://picsum.photos/seed/word-game-bear/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/bear.mp3',
    },
    {
      'id': 'word_011',
      'word': 'HORSE',
      'image_url': 'https://picsum.photos/seed/word-game-horse/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/horse.mp3',
    },
    {
      'id': 'word_012',
      'word': 'DUCK',
      'image_url': 'https://picsum.photos/seed/word-game-duck/500/500',
      'audio_url': 'https://cdn.putueducation.com/audio/en/duck.mp3',
    },
  ];

  Future<List<WordQuestion>> fetchQuestions({int limit = 10, String language = 'en'}) async {
    // Simulated network latency so loading state is exercised like a real call.
    await Future.delayed(const Duration(milliseconds: 400));

    final pool = List<Map<String, dynamic>>.from(_mockResponse)..shuffle(Random());
    final page = pool.take(limit).toList();
    return WordQuestion.listFromJson(page);
  }
}
