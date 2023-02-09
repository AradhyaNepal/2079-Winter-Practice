import 'package:flutter/material.dart';

class NotificationClickedPage extends StatelessWidget {
  static String route="NotificationClickedPage";
  const NotificationClickedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Notification Clicked",
            ),
          ),
          body: const Center(
            child: Text(
              "You Clicked The Notification and this page opened",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
