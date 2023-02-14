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
          imageUrl: Uri.parse("https://static.javatpoint.com/tutorial/firebase/images/dynamic-links-in-firebase2.png")
      ),
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse("https://www.google.com/"),
        packageName: "com.example.dynamic_links",
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}