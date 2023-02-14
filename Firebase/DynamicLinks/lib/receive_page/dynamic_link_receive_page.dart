import 'package:dynamic_links/utils/dynamic_link_generator.dart';
import 'package:flutter/material.dart';

class DynamicLinkReceivePage extends StatelessWidget {
  static const String route="/DynamicLinkReceive";
  const DynamicLinkReceivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Link Value Received"),
          ),
          body: Center(
            child: Text(
              _getText(arguments),
            ),
          ),
        ),
      ),
    );
  }

  String _getText(Map<String,dynamic> arguments){
    final name=arguments[DynamicLinkGenerator.nameKey];
    final phone=arguments[DynamicLinkGenerator.phoneKey];
    String returnValue="";
    returnValue+="Name: $name\n";
    returnValue+="Phone: $phone.";
    return returnValue;
  }
}
