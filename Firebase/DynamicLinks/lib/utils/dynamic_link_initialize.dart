import 'package:dynamic_links/firebase_options.dart';
import 'package:dynamic_links/utils/handle_link.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinkInitializer{
  static Future<void> initializeAndListen() async{
    await _initializeFirebaseCore();
    FirebaseAnalytics.instance;
    await _listenToUpcomingDeeplink();
  }



  static Future<void> _listenToUpcomingDeeplink() async{
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      print("Hello 123");
      try{
        handleDynamicLink(dynamicLinkData);
      }catch(e,s){
        debugPrint("ERROR-101 $e");
        debugPrint(s.toString());
      }
    },
        onError: (error){
          debugPrint("ERROR-101 $error");
        },
        onDone: (){
          debugPrint("Done-101");
        }
    );
  }



  static Future<void> _initializeFirebaseCore() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }


}
