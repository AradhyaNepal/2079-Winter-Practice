import 'package:awesome/show_notification_page.dart';
import 'package:awesome/utils/initialize.dart';
import 'package:flutter/material.dart';

void main() async{
  await initializeAwesomeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowNotificationPage(),
    );
  }
}
