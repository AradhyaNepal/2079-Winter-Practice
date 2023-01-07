import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_select_provider.dart';

class CityDropDownWidget extends StatelessWidget {
  const CityDropDownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: DropDownSelectProvider.nothingSelected,
        items: Provider.of<DropDownSelectProvider>(context).cityDropDown,
        onChanged: (value){
          Provider.of<DropDownSelectProvider>(context,listen: false).selectCity(value);
        }
    );
  }
}