
import 'package:awesome/utils/create_notification.dart';
import 'package:flutter/material.dart';

class ShowNotificationPage extends StatelessWidget {
  static const String route="/";
  const ShowNotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Notification"),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: (){
                NotificationSender(
                    context,
                    title: "Hello",
                    body: "How Are You!"
                ).createNotification();
              },
              child: const Text(
                "Show Notification",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
