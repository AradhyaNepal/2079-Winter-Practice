import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_select_provider.dart';

class ShowResultButtonWidget extends StatelessWidget {
  const ShowResultButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          Provider.of<DropDownSelectProvider>(context,listen: false).showValueButtonPressed();
        },
        child: const Text(
          "Show Value"
        ),
    );
  }
}
