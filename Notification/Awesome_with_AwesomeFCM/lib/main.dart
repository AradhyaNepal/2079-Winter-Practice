import 'package:awesome/screens/navigation_cliked_page/navigation_clicked_page.dart';
import 'package:awesome/screens/show_notification_page/show_notification_page.dart';
import 'package:awesome/utils/fcm_setup.dart';
import 'package:awesome/utils/local_storage.dart';
import 'package:awesome/utils/notification_setup_controller.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage().init();
  await NotificationSetupController.initializeAwesomeNotification();
  await FCMSetup.initializeRemoteNotifications(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //Used For Navigation when Popup Notification is Pressed.
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
    NotificationSetupController.setListener();
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

  /// Request FCM token to Firebase
  static Future<String> getFirebaseMessagingToken() async {
    //Send this token to your backend server and this way you got the "device address"
    //to send notifications. Its recommended to also send the native token to your server,
    //as not all push services are available by Cloud Messaging.
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
      }
      catch (exception){
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }
}
