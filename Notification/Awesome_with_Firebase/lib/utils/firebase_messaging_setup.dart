import 'dart:convert';
import 'dart:developer';

import 'package:awesome/main.dart';
import 'package:awesome/utils/create_notification.dart';
import 'package:awesome/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  int messageId=-1;
  try{
    messageId=int.parse(message.messageId??"-1");
  }catch(e){
    messageId=-1;
  }

  final map=message.data["Android"]??message.data["iOS"];
  var content=json.decode(map)["content"]["title"];

  NotificationCreateManager(
    null,
    id:messageId,
    title: content,
    body: content,
  ).createNotification();
}

class FirebaseMessagingSetup{
  Future<void> setupFirebaseMessaging() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print(settings.authorizationStatus);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      final map=message.data["Android"]??message.data["iOS"];
      print("MAP is $map");
      print("Type ${map.runtimeType}");
      final content=json.decode(map)["content"]["title"];
      NotificationCreateManager(
        MyApp.navigatorKey.currentState!.context,
        title: content,
        body: content,
      ).createNotification();
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.subscribeToTopic('Hello');
    if(LocalStorage().haveFcmKey()){
      print("Saved ${LocalStorage().getFcmToken()}");
    }else{
      final token=await FirebaseMessaging.instance.getToken();
      if(token!=null){
        print("Fetched $token");
        LocalStorage().setFCMKey(token);
      }

    }
  }

}