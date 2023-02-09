import 'dart:math';
import 'package:awesome/utils/local_storage.dart';
import 'package:awesome/widgets/open_snack_bar_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationSender{


  final BuildContext context;
  final String channelKey;
  final String title;
  final String body;
  final ActionType actionType;

  NotificationSender(this.context,{
    this.channelKey='basic_channel',
    required this.title,
    required this.body,
    this.actionType=ActionType.Default,
  });
  void createNotification() async{
    if(LocalStorage().haveNotificationPermission()){
      _createNotificationAfterHavingPermission();
    }
    else{
      _userApprovalAlertForPermission();
    }
  }

  Future<void> _userApprovalAlertForPermission() async {
     final userSaidOkay=await _showDialogForUserPermission();
    if(userSaidOkay==true){
      _userPackageToGrantPackage();
    }else{
      _showSnackBar("Notification Permission Not Granted");
    }
  }



  void _userPackageToGrantPackage() async{
    bool isAllowed= await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      final permissionGiven=await AwesomeNotifications().requestPermissionToSendNotifications();
      if(permissionGiven){
        _createNotificationAfterHavingPermission();
      }
      else{
        _showSnackBar("You denied the permission, now you need to manually add permission on setting to make notification work");
      }
      LocalStorage().setHaveNotificationPermission(permissionGiven);
    }else{
      _createNotificationAfterHavingPermission();
    }
  }

  Future<dynamic> _showDialogForUserPermission() async{
    if(!context.mounted)return;
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

  void _showSnackBar(String snackBarMessage) {
    if(!context.mounted)return;
    ScaffoldMessenger.of(context).showSnackBar(
      OpenSettingSnackBar(
        snackBarMessage:snackBarMessage,
      ),
    );
  }

  void _createNotificationAfterHavingPermission() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(100000),
            channelKey: channelKey,
            title: title,
            body: body,
            actionType: actionType,
        )
    );
  }

}