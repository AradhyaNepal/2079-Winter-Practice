import 'package:flutter/material.dart';
import 'package:province_district_city_pick/screens/drop_down/drop_down_page.dart';

class SplashPage extends StatefulWidget {
  static const String route="/";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushReplacementNamed(
          context,
          DropDownPage.route,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
