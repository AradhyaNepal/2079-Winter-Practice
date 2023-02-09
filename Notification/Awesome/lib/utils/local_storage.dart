import 'package:shared_preferences/shared_preferences.dart';

///Init before calling any method else it will throw error.
class LocalStorage{
  static final LocalStorage _instance=LocalStorage._();
  LocalStorage._();
  factory LocalStorage()=>_instance;

  late SharedPreferences _sharedPreferences;
  Future<void> init() async{
    _sharedPreferences=await SharedPreferences.getInstance();
  }

  static String haveNotificationPermissionKey="haveNotificationPermission";
  bool haveNotificationPermission(){
    return _sharedPreferences.getBool(haveNotificationPermissionKey)??false;
  }

  void setHaveNotificationPermission(bool permission){
    _sharedPreferences.setBool(haveNotificationPermissionKey, permission);
  }
}