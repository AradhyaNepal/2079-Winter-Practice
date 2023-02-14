import 'package:dynamic_links/main.dart';
import 'package:dynamic_links/receive_page/dynamic_link_receive_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void handleDynamicLink(PendingDynamicLinkData dynamicLinkData) {
  final paramsMap=dynamicLinkData.link.queryParameters;
  MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    DynamicLinkReceivePage.route,
        (route) => false,
    arguments: paramsMap,
  );
}