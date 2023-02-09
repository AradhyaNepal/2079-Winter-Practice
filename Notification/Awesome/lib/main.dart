import 'package:awesome/screens/navigation_cliked_page/navigation_clicked_page.dart';
import 'package:awesome/screens/show_notification_page/show_notification_page.dart';
import 'package:awesome/utils/initialize.dart';
import 'package:awesome/utils/local_storage.dart';
import 'package:awesome/utils/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void main() async{
  await initializeAwesomeNotification();
  await LocalStorage().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:  NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Awesome Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ShowNotificationPage.route,
      routes: {
        ShowNotificationPage.route:(context)=>const ShowNotificationPage(),
        NotificationClickedPage.route:(context)=>const NotificationClickedPage(),
      },
    );
  }
}
