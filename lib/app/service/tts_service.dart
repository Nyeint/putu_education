import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  // Private constructor
  TtsService._privateConstructor() {
    _flutterTts = FlutterTts();
    _initializeTts();
  }

  // Static instance
  static final TtsService _instance = TtsService._privateConstructor();

  // Getter to access the instance
  static TtsService get instance => _instance;

  // FlutterTts instance
  late FlutterTts _flutterTts;

  FlutterTts get flutterTts => _flutterTts;

  void _initializeTts() {
    _flutterTts.awaitSpeakCompletion(true);
    // Additional configuration can be done here
  }

  void speak(String name) async{
    await flutterTts.stop();
    await flutterTts.speak(name);
  }
}