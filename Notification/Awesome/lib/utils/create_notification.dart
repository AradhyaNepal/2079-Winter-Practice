import 'package:awesome/main.dart';
import 'package:awesome/widgets/open_snack_bar_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationManager{
  static String haveNotificationPermissionKey="haveNotificationPermission";
  static String askedUserPermissionKey="askedUserPermission";
  static void createNotification() async{
    final sharedPreferences=await SharedPreferences.getInstance();
    bool askedUserPermission=sharedPreferences.getBool(askedUserPermissionKey)??false;
    bool haveNotificationPermission=sharedPreferences.getBool(haveNotificationPermissionKey)??false;
    if(askedUserPermission){
      _manageAskedPermissionScenario(haveNotificationPermission);
    }else{
      _manageNotAskedPermissionScenario();
    }
  }

  static void _manageNotAskedPermissionScenario() async{
    final userSaidOkay=await _showDialogForUserPermission();
    if(userSaidOkay){
      _userPackageToGrantPackage();
    }else{
      _showSnackBar("Notification Permission Not Granted");
    }
  }

  static void _userPackageToGrantPackage() async{
    final sharedPreferences=await SharedPreferences.getInstance();
    bool isAllowed= await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      final permissionGiven=await AwesomeNotifications().requestPermissionToSendNotifications();
      if(permissionGiven){
        _createNotificationAfterPermission();
      }
      else{
        _showSnackBar("You denied the permission, now you need to manually add permission on setting to make notification work");
      }
      sharedPreferences.setBool(haveNotificationPermissionKey,permissionGiven);
      sharedPreferences.setBool(askedUserPermissionKey,true);
    }else{
      _createNotificationAfterPermission();
    }
  }

  static Future<dynamic> _showDialogForUserPermission() async{
    final context=MyApp.scaffoldMessengerState.currentContext;
    if(context==null) return false;
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Notification Permission"),
            content: const Text("This app needs notification permission for bla bla bla bla..."),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context,true);
                },
                child: const Text(
                  "Okay",
                ),
              ),
            ],
          );
        }
    );
  }

  static void _manageAskedPermissionScenario(bool haveNotificationPermission) {
    if(haveNotificationPermission){
      _createNotificationAfterPermission();
    }else{
      _showSnackBar("Open Setting To Add Notification Permission");
    }
  }

  static void _showSnackBar(String snackBarMessage) {
    MyApp.scaffoldMessengerState.currentState?.showSnackBar(
      OpenSettingSnackBar(
        snackBarMessage:snackBarMessage,
      ),
    );
  }

  static void _createNotificationAfterPermission() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            actionType: ActionType.Default
        )
    );
  }

}