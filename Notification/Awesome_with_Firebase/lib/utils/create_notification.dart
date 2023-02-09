
import 'package:awesome/utils/notification_setup_controller.dart';
import 'package:awesome/widgets/open_snack_bar_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationCreateManager{

  static const String permissionDenied="Permission Denied. Cannot Send Notification";

  final BuildContext context;
  final String channelKey;
  final String title;
  final String body;
  final ActionType actionType;

  ///Manages Permissions and styles before creating a notification.
  NotificationCreateManager(this.context,{
    this.channelKey=NotificationSetupController.channel1,
    required this.title,
    required this.body,
    this.actionType=ActionType.Default,
  });
  void createNotification() async{
    bool isAllowed= await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      _userApprovalForPermission();
    }else{
      _createNotificationAfterHavingPermission();
    }

  }

  Future<void> _userApprovalForPermission() async {
     final userSaidOkay=await _showDialogForUserPermission();
    if(userSaidOkay==true){
      _userPackageToGetPermission();
    }else{
      _showSnackBar(permissionDenied);
    }
  }

  Future<void> _userPackageToGetPermission() async {
    final permissionGiven=await AwesomeNotifications().requestPermissionToSendNotifications();
    if(permissionGiven){
      _createNotificationAfterHavingPermission();
    }
    else{
      _showSnackBar(permissionDenied);
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
    ScaffoldMessenger.of(context)..removeCurrentSnackBar()
      ..showSnackBar(
      OpenSettingSnackBar(
        snackBarMessage:snackBarMessage,
      ),
    );
  }

  void _createNotificationAfterHavingPermission() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: channelKey,
            title: title,
            body: body,
            bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'REPLY',
              label: 'Reply Message',
              requireInputText: true,
              actionType: ActionType.SilentAction
          ),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
    _showSnackBar("Notification Successfully Send");
  }

}