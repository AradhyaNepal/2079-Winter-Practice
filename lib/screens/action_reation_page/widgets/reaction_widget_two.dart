import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/provider/action_reaction_provider.dart';

class ReactionWidgetTwo extends StatelessWidget {
  const ReactionWidgetTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Pressed ${Provider.of<ActionReactionProvider>(context).pressedTimes}"
    );
  }
}