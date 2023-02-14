import 'package:awesome/utils/local_storage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';

class FCMSetup{
  static Future<void> initializeRemoteNotifications({
    required bool debug
  }) async {
    await LocalStorage().init();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: mySilentDataHandle,
        onFcmTokenHandle: myFcmTokenHandle,
        onNativeTokenHandle: myNativeTokenHandle,
        debug: debug
    );
    await setFirebaseMessagingToken();

  }

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    switch(silentData.createdLifeCycle){
      case NotificationLifeCycle.AppKilled:
        print("App Killed");
        break;
      case NotificationLifeCycle.Background:
        print("Background");
        break;
      case NotificationLifeCycle.Foreground:
        print("Forground");
        break;
      default:
        break;
    }
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }

  // Request FCM token to Firebase
  static Future<void> setFirebaseMessagingToken() async {
    //Send this token to your backend server and this way you got the "device address"
    // to send notifications. Its recommended to also send the native token to your server,
    // as not all push services are available by Cloud Messaging.
    bool haveToken=LocalStorage().haveFcmKey();
    if(haveToken){
      print("Saved Token ${LocalStorage().getFcmToken()}");
      return;
    }
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        final firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
        LocalStorage().setFCMKey(firebaseAppToken);
        print("Fetched Token $firebaseAppToken");
      }
      catch (exception){
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
  }

}