import 'package:awesome/main.dart';
import 'package:awesome/screens/navigation_cliked_page/navigation_clicked_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';



class NotificationSetupController{

  static const String channel1="basic_channel_1";

  static Future<void> initializeAwesomeNotification() async{
    await AwesomeNotifications().initialize(
      null,//Null to use default app icon,
      [
        NotificationChannel(
          channelKey: channel1,
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.red,
          ledColor: Colors.white,
        ),
      ],
      debug: true,
    );
  }

  static void setListener(){
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:  NotificationSetupController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationSetupController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationSetupController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationSetupController.onDismissActionReceivedMethod
    );
  }


  //Note:
  //We need to use @pragma("vm:entry-point") in each static method to identify
  //to the Flutter engine that the dart address will be called from native and should be preserved.


  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    print(receivedAction.id);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(NotificationClickedPage.route,
            (route) => (route.settings.name != NotificationClickedPage.route) || route.isFirst,
        arguments: receivedAction);
  }
}