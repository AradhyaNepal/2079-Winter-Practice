import 'package:flutter/material.dart';

class ActionReactionProvider with ChangeNotifier{

  String _firstActionValue="";
  int _pressedTimes=0;
  String get firstActionValue=>_firstActionValue;
  int get pressedTimes=>_pressedTimes;
  void firstActionSubmitted(String value){
    _firstActionValue=value;
    notifyListeners();
  }

  void pressed(){
    _pressedTimes++;
    notifyListeners();
  }
}