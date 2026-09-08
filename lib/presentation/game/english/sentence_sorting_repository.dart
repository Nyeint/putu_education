// Path: english/sentence_sorting_repository.dart
import 'dart:math';

import '../model/sentence_question.dart';

/// Data source for the Sentence Sorting Game.
///
/// Stands in for a real `GET /api/v1/games/sentence-sorting?limit=&language=`
/// call (mirrors `WordSortingRepository`) — same response shape, same
/// `limit`/`language` query params, same randomization contract. Swap the
/// body of [fetchQuestions] for a `dio` call once the backend exists; nothing
/// else in the game needs to change since callers only depend on
/// [SentenceQuestion].
class SentenceSortingRepository {
  const SentenceSortingRepository();

  static const List<Map<String, dynamic>> _mockResponse = [
    {
      'id': 'sentence_001',
      'words': ['A', 'cat', 'is', 'under', 'the', 'table'],
      'image_url': 'https://www.shutterstock.com/image-photo/cat-under-table-260nw-494788639.jpg',
    },
    {
      'id': 'sentence_002',
      'words': ['There', 'is', 'a', 'squirrel', 'on', 'the', 'tree'],
      'image_url':
          'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    },
    {
      'id': 'sentence_003',
      'words': ['A', 'horse', 'is', 'running'],
      'image_url':
          'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'id': 'sentence_004',
      'words': ['Elephant', 'is', 'so', 'big'],
      'image_url':
          'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'id': 'sentence_005',
      'words': ['A', 'dog', 'is', 'barking'],
      'image_url': 'https://www.shutterstock.com/image-photo/cat-under-table-260nw-494788639.jpg',
    },
    {
      'id': 'sentence_006',
      'words': ['The', 'zebra', 'has', 'stripes'],
      'image_url':
          'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    },
    {
      'id': 'sentence_007',
      'words': ['A', 'monkey', 'likes', 'bananas'],
      'image_url':
          'https://images.unsplash.com/photo-1598755257130-c2aaca1f061c?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'id': 'sentence_008',
      'words': ['The', 'rabbit', 'is', 'fast'],
      'image_url':
          'https://images.unsplash.com/photo-1592670130429-fa412d400f50?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2lsZCUyMGFuaW1hbHxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'id': 'sentence_009',
      'words': ['A', 'giraffe', 'is', 'tall'],
      'image_url': 'https://www.shutterstock.com/image-photo/cat-under-table-260nw-494788639.jpg',
    },
    {
      'id': 'sentence_010',
      'words': ['The', 'panda', 'eats', 'bamboo'],
      'image_url':
          'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?cs=srgb&dl=pexels-pixabay-47547.jpg&fm=jpg',
    },
  ];

  Future<List<SentenceQuestion>> fetchQuestions({int limit = 10, String language = 'en'}) async {
    // Simulated network latency so loading state is exercised like a real call.
    await Future.delayed(const Duration(milliseconds: 400));

    final pool = List<Map<String, dynamic>>.from(_mockResponse)..shuffle(Random());
    final page = pool.take(limit).toList();
    return SentenceQuestion.listFromJson(page);
  }
}
