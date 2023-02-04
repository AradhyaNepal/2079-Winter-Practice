
import 'package:flutter/material.dart';
import 'package:riverpod_practice/choose_action/widgets/custom_select_page_button.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';

class ChooseActionPage extends StatelessWidget {
  static const String route="/";
  const ChooseActionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          appBar:AppBar(
            title: const Text("Riverpod Practice"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: const [
                CustomSelectPageButton(
                  whichPageToGo: CounterPage.route,
                ),
                CustomSelectPageButton(
                  whichPageToGo: ServerFetchPage.route,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
