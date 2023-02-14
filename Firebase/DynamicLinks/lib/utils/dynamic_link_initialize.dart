import 'package:dynamic_links/firebase_options.dart';
import 'package:dynamic_links/main.dart';
import 'package:dynamic_links/receive_page/dynamic_link_receive_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinkInitializer{
  static final DynamicLinkInitializer _instance=DynamicLinkInitializer._();
  DynamicLinkInitializer._();
  factory DynamicLinkInitializer()=>_instance;
  Future<void> initializeAndListen() async{
    await _initializeFirebaseCore();
    await _listenToUpcomingDeeplink();
  }

  bool _listeningAlreadySubscribed=false;
  Future<void> _listenToUpcomingDeeplink() async{
    if(_listeningAlreadySubscribed) return;
    _listeningAlreadySubscribed=true;
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      try{
        final String uri = Uri.decodeFull(dynamicLinkData.link.toString());
        final values=uri.toString().split(".link/?").last.split("&");
        MyApp.navigatorKey.currentState?.pushNamed(DynamicLinkReceivePage.route);

      }catch(e,s){
        debugPrint(e.toString());
        debugPrint(s.toString());
      }
    },
        onError: (error){
          debugPrint(error);
        },
        onDone: (){
          debugPrint("Done");
        }
    );
  }

  Future<void> _initializeFirebaseCore() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }


}
