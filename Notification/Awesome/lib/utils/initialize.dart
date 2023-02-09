import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> initializeAwesomeNotification() async{
  await AwesomeNotifications().initialize(
    null,//Null to use default app icon,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
        ),
        NotificationChannel(
          channelGroupKey: 'basic_channel_group_2',
          channelKey: 'basic_channel_2',
          channelName: 'Basic notifications 2',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group',
        ),
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group_2',
            channelGroupName: 'Basic group 2',
        ),
      ],
      debug: true,
  );
}