
import 'package:flutter/material.dart';

class ShowAwesomeNotificationButton extends StatelessWidget {
  const ShowAwesomeNotificationButton({
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
            title: const Text(
                "Notification"
            ),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: (){

              },
              child: const Text(
                  "Show Notification"
              ),
            ),
          ),
        ),
      ),
    );
  }
}
