import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:firebase_notification/local_notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //mist not me more than 30 seconds else OS will terminate it.

  print("Background Notification");
  sendNotification(message);
  runApp(const MyApp());
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  listenToNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.subscribeToTopic('weather');
  await _setup();
  runApp(const MyApp());
}
void listenToNotification()async{
  await Future.delayed(Duration(seconds: 1));
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Forground Notification");
      sendNotification(message);
    }
  });
}

void sendNotification(RemoteMessage message)async{
  final notification =message.notification;
  if(notification==null)return;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            "1",
            "Channel One",
            priority: Priority.high,
          ),
      ),
  );
}

Future<void> _setup() async {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

  // #2
  const initSettings =
  InitializationSettings(android: androidSetting,);

  // #3
  await _localNotificationsPlugin.initialize(initSettings).then((_) {
    debugPrint('setupPlugin: setup success');
  }).catchError((Object error) {
    debugPrint('Error: $error');
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocalNotification(),
    );
  }
}
