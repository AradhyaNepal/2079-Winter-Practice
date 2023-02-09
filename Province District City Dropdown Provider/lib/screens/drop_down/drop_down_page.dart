import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_fetch_provider.dart';
import 'package:province_district_city_pick/screens/drop_down/provider/dropdown_select_provider.dart';
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
        create: (context)=>DropDownFetchProvider(),
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
      appBar: AppBar(
        title: const Text("DropDowns"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Consumer<DropDownFetchProvider>(
          builder: (context,provider,child) {
            if(provider.isLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(provider.hasError){
              return Center(
                child: Text(
                  provider.errorMessage,
                ),
              );
            }
            return ChangeNotifierProvider(
              create: (context)=>DropDownSelectProvider(
                  provinceList: provider.provinceList,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ProvinceDropDownWidget(),
                  DistrictDropDownWidget(),
                  CityDropDownWidget(),
                  ShowResultButtonWidget(),
                  ResultTextWidget(),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}








