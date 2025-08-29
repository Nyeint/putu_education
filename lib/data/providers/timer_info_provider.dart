import 'package:flutter/cupertino.dart';

class TimerInfoProvider extends ChangeNotifier{
  DateTime _expireTime = DateTime.now();
  DateTime get expireTime => _expireTime;

  set increaseExpireTime(int seconds){
    Duration difference = expireTime.difference(DateTime.now());
    if(difference<Duration.zero || difference==Duration.zero){
      _expireTime = DateTime.now();
    }
    _expireTime = expireTime.add(Duration(seconds: seconds));
    notifyListeners();
  }
}