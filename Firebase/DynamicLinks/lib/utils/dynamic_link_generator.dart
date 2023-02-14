import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkGenerator{
  static const String nameKey="name",phoneKey="phone";
  static const String dynamicLink="https://aradhyadynamicpractice.page.link";
  Future<String> generateDeepLink({
  required nameValue,
  required phoneValue,
  }) async{
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("${DynamicLinkGenerator.dynamicLink}/?${DynamicLinkGenerator.nameKey}=$nameValue&${DynamicLinkGenerator.phoneKey}=$phoneValue"),
      uriPrefix: DynamicLinkGenerator.dynamicLink,
      socialMetaTagParameters: SocialMetaTagParameters(
          title: "Aradhya Practice",
          imageUrl: Uri.parse("https://cliply.co/wp-content/uploads/2021/08/472108440_HELLO_STICKER_400.png")
      ),
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse("https://www.google.com/"),
        packageName: "com.example.dynamic_links",
      ),
      iosParameters: const IOSParameters(bundleId: "com.example.dynamic_links"),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}