import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const String route="/splashpage";
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(

        ),
      ),
    );
  }
}
