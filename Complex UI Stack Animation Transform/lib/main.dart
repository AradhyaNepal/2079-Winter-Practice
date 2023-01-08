import 'package:complex_ui_animation_stack_transform/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex UI Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route:(context)=>const SplashPage(),
      },
    );
  }
}
