import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_select_provider.dart';

class ProvinceDropDownWidget extends StatelessWidget {
  const ProvinceDropDownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<DropDownSelectProvider>(context);
    return DropdownButton<int>(
        value: provider.selectedProvinceIndex,
        items: provider.provinceDropDown,
        onChanged: (value){
          Provider.of<DropDownSelectProvider>(context,listen: false).selectProvince(value);
        }
    );
  }
}