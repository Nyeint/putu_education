// Path: features/topics/domain/repositories/game_repo.dart
import '../../../../data/model/response_ob.dart';

abstract class GameRepo {
  /// [subject] is the API's language code for the game questions: 'en' for
  /// English, 'my' for Myanmar.
  Future<ResponseOb> getChoosePictureGame({required String subject});

  /// [subject] is the API's language code for the word-sorting questions:
  /// 'en' for English, 'my' for Myanmar.
  Future<ResponseOb> getWordSortingGame({required String subject});

  /// [subject] is the API's language code for the sentence-sorting
  /// questions: 'en' for English, 'my' for Myanmar.
  Future<ResponseOb> getSentenceSortingGame({required String subject});
}
