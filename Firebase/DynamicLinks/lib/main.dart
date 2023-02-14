import 'package:dynamic_links/receive_page/dynamic_link_receive_page.dart';
import 'package:dynamic_links/send_page/dynamic_link_send_page.dart';
import 'package:dynamic_links/utils/dynamic_link_initialize.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DynamicLinkInitializer.initializeAndListen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey=GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: DynamicLinkSendPage.route,
      routes: {
        DynamicLinkSendPage.route:(_)=>const DynamicLinkSendPage(),
        DynamicLinkReceivePage.route:(_)=>const DynamicLinkReceivePage(),
      },
    );
  }
}


