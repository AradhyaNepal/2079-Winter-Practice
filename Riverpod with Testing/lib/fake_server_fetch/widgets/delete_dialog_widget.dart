import 'package:flutter/material.dart';

class DeleteDataDialog extends StatelessWidget {
  const DeleteDataDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete!"),
      content: const Text("Do You Really Want To Delete??"),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context,true);
            },
            child: const Text("Yes"),
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context,false);
            },
            child: const Text("No"),
        ),
      ],
    );
  }
}