import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_select_provider.dart';

class ResultTextWidget extends StatelessWidget {
  const ResultTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<DropDownSelectProvider>(context).displayValue,
    );
  }
}
