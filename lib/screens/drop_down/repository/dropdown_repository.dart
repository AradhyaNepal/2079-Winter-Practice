import 'dart:math';

import 'package:province_district_city_pick/constants/exceptions.dart';
import 'package:province_district_city_pick/screens/drop_down/model/district.dart';
import 'package:province_district_city_pick/screens/drop_down/model/province.dart';
import 'package:province_district_city_pick/screens/drop_down/utils/fake_json.dart';

class DropDownRepository{
  List<Province> getDataFromServer(){
    bool error =Random().nextInt(10)==0;
    if(error) throw InternetException();
    final data=FakeData.jsonData;
    List<Province> province=[];
    for(String keyWhichHaveProvinceName in data.keys){
      province.add(
          Province(
              name: keyWhichHaveProvinceName,
              districtList: District.getListOfDistrict(data[keyWhichHaveProvinceName]),
          )
      );
    }
    return province;
  }
}
