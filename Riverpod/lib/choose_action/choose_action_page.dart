
import 'package:flutter/material.dart';
import 'package:riverpod_practice/choose_action/widgets/custom_select_page_button.dart';

class ChooseActionPage extends StatelessWidget {
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
              children: [
                CustomSelectPageButton(
                  whichPageToGo: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
