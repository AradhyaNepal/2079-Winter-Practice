import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/provider/action_reaction_provider.dart';

class ActionWidgetTwo extends StatelessWidget {
  const ActionWidgetTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          Provider.of<ActionReactionProvider>(context,listen: false).pressed();
        },
        child: const Text("Press"),
    );
  }
}