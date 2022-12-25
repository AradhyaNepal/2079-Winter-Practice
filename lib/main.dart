import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practicequestion/constants/screen_size.dart';
import 'package:practicequestion/presentation/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenSize.kScreenSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return MaterialApp(
            title: 'Ek Bana',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        },
        child: const MainPage(),
      );
  }
}
