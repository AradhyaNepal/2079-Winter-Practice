import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseActionAppBar extends StatelessWidget implements PreferredSize{
  const ChooseActionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Riverpod Practice"),
    );
  }

  @override
  // TODO: implement child
  Widget get child => const SizedBox();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
