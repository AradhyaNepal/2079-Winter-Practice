
import 'package:flutter/material.dart';

class CustomSelectPageButton extends StatelessWidget {
  final String whichPageToGo;
  final VoidCallback? extraTaskBeforeGoing;
  const CustomSelectPageButton({
    required this.whichPageToGo,
    this.extraTaskBeforeGoing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ElevatedButton(
          onPressed: (){
            if(extraTaskBeforeGoing!=null){
              extraTaskBeforeGoing!();
            }
            Navigator.pushNamed(context,whichPageToGo);
          },
          child: Text(
            whichPageToGo,
          ),
      ),
    );
  }
}
