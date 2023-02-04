import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/choose_action/choose_action_page.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';

void main() {
  runApp(
      const ProviderScope(
          child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ChooseActionPage.route,
      routes: {
        ChooseActionPage.route:(_)=>const ChooseActionPage(),
        CounterPage.route:(_)=>const CounterPage(),
      },
    );
  }
}
