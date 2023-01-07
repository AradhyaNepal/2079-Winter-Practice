import 'package:provider/provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/provider/action_reaction_provider.dart';

import 'package:flutter/material.dart';

class ActionWidgetOne extends StatelessWidget {
  const ActionWidgetOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value){
        Provider.of<ActionReactionProvider>(context,listen: false).firstActionSubmitted(value);
      },
    );
  }
}
