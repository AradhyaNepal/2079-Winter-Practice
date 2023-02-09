import 'package:shared_preferences/shared_preferences.dart';

///Init before calling any method else it will throw error.
class LocalStorage{
  static final LocalStorage _instance=LocalStorage._();
  LocalStorage._();
  factory LocalStorage()=>_instance;

  late SharedPreferences sharedPreferences;
  void init() async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
}