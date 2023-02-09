import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  static final LocalStorage _instance=LocalStorage._();
  LocalStorage._();
  factory LocalStorage()=>_instance;

  static const String fcmTokenKey="FCMKey";

  late SharedPreferences _sharedPreferences;
  bool _initialized=false;

  Future<void> init()async{
    if(_initialized)return;
    _sharedPreferences=await SharedPreferences.getInstance();
    _initialized=true;
  }

  void setFCMKey(String key){
    _sharedPreferences.setString(fcmTokenKey, key);
  }

  bool haveFcmKey(){
    return _sharedPreferences.getString(fcmTokenKey)!=null;
  }

  String getFcmToken(){
    return _sharedPreferences.getString(fcmTokenKey)??"";
  }
}