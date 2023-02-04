
import 'package:flutter/material.dart';

class CustomSelectPageButton extends StatelessWidget {
  final String whichPageToGo;
  const CustomSelectPageButton({
    required this.whichPageToGo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context,whichPageToGo);
        },
        child: Text(
          whichPageToGo,
        ),
    );
  }
}
