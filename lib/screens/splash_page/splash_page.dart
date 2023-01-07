import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ui_provider/constants/screen_utils_size.dart';
import 'package:simple_ui_provider/screens/action_reation_page/action_reaction_page.dart';

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
    Future.delayed(
        const Duration(seconds: 1),
            (){
          Navigator.pushReplacementNamed(context, ActionReactionPage.route);
            }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: KScreenUtilsSize.height.h,
        width: KScreenUtilsSize.width.w,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
