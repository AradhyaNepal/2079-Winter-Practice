import 'package:dynamic_links/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class DynamicLinkInitialize{
  Future<void> initialize() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
