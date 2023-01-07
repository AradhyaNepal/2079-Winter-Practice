import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/provider/action_reaction_provider.dart';
import 'package:simple_ui_provider/screens/action_reation_page/widgets/action_widget_one.dart';
import 'package:simple_ui_provider/screens/action_reation_page/widgets/action_widget_two.dart';
import 'package:simple_ui_provider/screens/action_reation_page/widgets/reaction_widget_one.dart';
import 'package:simple_ui_provider/screens/action_reation_page/widgets/reaction_widget_two.dart';

class ActionReactionPage extends StatelessWidget {
  static const String route="/actionReactionPage";
  const ActionReactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=>ActionReactionProvider(),
      child: const _ActionReactionContent(),
    );
  }
}

class _ActionReactionContent extends StatelessWidget {
  const _ActionReactionContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const[
          ActionWidgetOne(),
          ActionWidgetTwo(),
          ReactionWidgetOne(),
          ReactionWidgetTwo(),
        ],
      ),
    );
  }
}





