import 'package:flutter/cupertino.dart';

enum ThemeType{
  light,
  dark
}

enum Language{
  mm,
  en
}

class SettingsInfoProvider extends ChangeNotifier{
  ThemeType _themeType = ThemeType.light;
  ThemeType get themeType => _themeType;

  Language _language = Language.en;
  Language get language => _language;

  set themeType(ThemeType value){
    _themeType = value;
    notifyListeners();
  }

  set language(Language value){
    _language = value;
    notifyListeners();
  }
}