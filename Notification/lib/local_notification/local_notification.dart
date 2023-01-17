import 'package:flutter/material.dart';

class LocalNotification extends StatelessWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: ElevatedButton(
            child: const Text("Send Notification"),
            onPressed: (){

            },
          ),
        ),
      ),
    );
  }
}
