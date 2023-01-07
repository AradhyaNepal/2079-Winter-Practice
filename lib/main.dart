import 'package:flutter/material.dart';
import 'package:province_district_city_pick/screens/drop_down/drop_down_page.dart';
import 'package:province_district_city_pick/screens/splash_page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Province District City Dropdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route:(context)=>const SplashPage(),
        DropDownPage.route:(context)=>const DropDownPage(),
      },
    );
  }
}
