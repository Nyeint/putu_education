class GameModel {
  List<GameData>? data;

  GameModel({this.data});

  GameModel.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    // Some endpoints return `data` as a plain list; others (paginated
    // responses) wrap the list one level deeper as `data.data`. Handle both
    // so a change in pagination on the backend doesn't crash parsing.
    final List<dynamic>? rawList = raw is List
        ? raw
        : (raw is Map ? (raw['data'] as List<dynamic>?) : null);
    if (rawList != null) {
      data = rawList.map((v) => GameData.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameData {
  int? id;
  String? gameType;
  String? prompt;
  String? promptMm;
  String? image;
  String? audio;
  String? audioMm;
  String? targetText;
  int? lessonId;
  List<Options>? options;
  int? sortOrder;
  bool? isActive;
  Subject? subject;
  Subject? category;
  Lesson? lesson;
  String? createdAt;
  String? updatedAt;

  GameData(
      {this.id,
        this.gameType,
        this.prompt,
        this.promptMm,
        this.image,
        this.audio,
        this.audioMm,
        this.targetText,
        this.lessonId,
        this.options,
        this.sortOrder,
        this.isActive,
        this.subject,
        this.category,
        this.lesson,
        this.createdAt,
        this.updatedAt});

  GameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameType = json['game_type'];
    prompt = json['prompt'];
    promptMm = json['prompt_mm'];
    image = json['image'];
    audio = json['audio'];
    audioMm = json['audio_mm'];
    targetText = json['target_text'];
    lessonId = json['lesson_id'];
    final rawOptions = json['options'];
    // `options` shows up in three shapes depending on the endpoint: a plain
    // list (choose-picture), a paginated `{"data": [...]}` wrapper, or a
    // single option object (e.g. sentence-sorting's `{"tiles": [...]}`) -
    // guard against all three instead of assuming `!= null` means "is a
    // List".
    final List<dynamic>? rawOptionsList = rawOptions is List
        ? rawOptions
        : (rawOptions is Map
            ? (rawOptions['data'] is List ? rawOptions['data'] as List<dynamic> : <dynamic>[rawOptions])
            : null);
    if (rawOptionsList != null) {
      options = rawOptionsList.map((v) => Options.fromJson(v)).toList();
    }
    sortOrder = json['sort_order'];
    isActive = json['is_active'];
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    category = json['category'] != null
        ? new Subject.fromJson(json['category'])
        : null;
    lesson =
    json['lesson'] != null ? new Lesson.fromJson(json['lesson']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_type'] = this.gameType;
    data['prompt'] = this.prompt;
    data['prompt_mm'] = this.promptMm;
    data['image'] = this.image;
    data['audio'] = this.audio;
    data['audio_mm'] = this.audioMm;
    data['target_text'] = this.targetText;
    data['lesson_id'] = this.lessonId;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['sort_order'] = this.sortOrder;
    data['is_active'] = this.isActive;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.lesson != null) {
      data['lesson'] = this.lesson!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Options {
  int? id;
  String? text;
  String? image;
  String? imageUrl;
  String? audioUrl;
  bool? isCorrect;
  dynamic prefix;
  List<String>? tiles;

  Options(
      {this.id,
        this.text,
        this.image,
        this.imageUrl,
        this.audioUrl,
        this.isCorrect,
        this.prefix,
        this.tiles
      });

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    image = json['image'];
    imageUrl = json['image_url'];
    audioUrl = json['audio_url'];
    isCorrect = json['is_correct'];
    prefix = json['prefix'];
    tiles = (json['tiles'] as List<dynamic>?)?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['audio_url'] = this.audioUrl;
    data['is_correct'] = this.isCorrect;
    data['prefix'] = this.prefix;
    if (this.tiles != null) {
      data['tiles'] = this.tiles;
    }
    return data;
  }
}

class Subject {
  int? id;
  String? name;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Lesson {
  int? id;
  String? word;
  String? imageUrl;

  Lesson({this.id, this.word, this.imageUrl});

  Lesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['image_url'] = this.imageUrl;
    return data;
  }
}