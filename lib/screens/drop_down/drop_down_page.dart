import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/province_district_city_pick_provider.dart';
import 'package:province_district_city_pick/screens/drop_down/widgets/city_drop_down_widget.dart';
import 'package:province_district_city_pick/screens/drop_down/widgets/district_drop_down_widget.dart';
import 'package:province_district_city_pick/screens/drop_down/widgets/province_drop_down_widget.dart';
import 'package:province_district_city_pick/screens/drop_down/widgets/result_text_widget.dart';
import 'package:province_district_city_pick/screens/drop_down/widgets/show_result_button_widget.dart';

class DropDownPage extends StatelessWidget {
  static const String route="/DropDownPage";
  const DropDownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>ProvinceDistrictCityPickProvider(),
        child: const _DropDownPageContent()
    );
  }
}

class _DropDownPageContent extends StatelessWidget {
  const _DropDownPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: const [
            ProvinceDropDownWidget(),
            DistrictDropDownWidget(),
            CityDropDownWidget(),
            ShowResultButtonWidget(),
            ResultTextWidget(),
          ],
        ),
      ),
    );
  }
}








