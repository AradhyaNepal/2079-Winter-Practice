import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/provider/action_reaction_provider.dart';

class ReactionWidgetOne extends StatelessWidget {
  const ReactionWidgetOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<ActionReactionProvider>(context).firstActionValue,
    );
  }
}
