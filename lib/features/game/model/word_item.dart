// Path: model/word_item.dart
class WordItem {
  final int id;
  final String word;
  final String audioUrl;
  final String imageUrl;

  const WordItem({
    required this.id,
    required this.word,
    required this.audioUrl,
    required this.imageUrl,
  });
}

const List<WordItem> wordGameMasterList = [
  WordItem(
    id: 1,
    word: 'Cat',
    audioUrl: 'assets/audio/cat.mp3',
    imageUrl: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=500',
  ),
  WordItem(
    id: 2,
    word: 'Squirrel',
    audioUrl: 'assets/audio/squirrel.mp3',
    imageUrl: 'https://images.unsplash.com/photo-1504006833117-8886a355efbf?q=80&w=500',
  ),
  WordItem(
    id: 3,
    word: 'Zebra',
    audioUrl: 'assets/audio/zebra.mp3',
    imageUrl: 'https://images.unsplash.com/photo-1501705388883-4ed8a543392c?q=80&w=500',
  ),
  WordItem(
    id: 4,
    word: 'Dog',
    audioUrl: 'assets/audio/dog.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-dog/500/500',
  ),
  WordItem(
    id: 5,
    word: 'Elephant',
    audioUrl: 'assets/audio/elephant.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-elephant/500/500',
  ),
  WordItem(
    id: 6,
    word: 'Lion',
    audioUrl: 'assets/audio/lion.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-lion/500/500',
  ),
  WordItem(
    id: 7,
    word: 'Tiger',
    audioUrl: 'assets/audio/tiger.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-tiger/500/500',
  ),
  WordItem(
    id: 8,
    word: 'Monkey',
    audioUrl: 'assets/audio/monkey.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-monkey/500/500',
  ),
  WordItem(
    id: 9,
    word: 'Rabbit',
    audioUrl: 'assets/audio/rabbit.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-rabbit/500/500',
  ),
  WordItem(
    id: 10,
    word: 'Bear',
    audioUrl: 'assets/audio/bear.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-bear/500/500',
  ),
  WordItem(
    id: 11,
    word: 'Horse',
    audioUrl: 'assets/audio/horse.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-horse/500/500',
  ),
  WordItem(
    id: 12,
    word: 'Duck',
    audioUrl: 'assets/audio/duck.mp3',
    imageUrl: 'https://picsum.photos/seed/word-game-duck/500/500',
  ),
];
