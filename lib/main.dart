import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ui_provider/constants/screen_utils_size.dart';
import 'package:simple_ui_provider/screens/action_reation_page/action_reaction_page.dart';
import 'package:simple_ui_provider/screens/splash_page/splash_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:KScreenUtilsSize.size,
      builder: (context,child) {
        return MaterialApp(
          title: 'Simple UI Provider',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SplashPage.route,
          routes: {
            SplashPage.route:(context)=>const SplashPage(),
            ActionReactionPage.route:(context)=>const ActionReactionPage(),
          },
        );
      }
    );
  }
}


