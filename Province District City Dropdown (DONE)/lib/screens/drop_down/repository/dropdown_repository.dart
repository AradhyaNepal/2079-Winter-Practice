import 'dart:math';

import 'package:province_district_city_pick/constants/exceptions.dart';
import 'package:province_district_city_pick/screens/drop_down/model/district.dart';
import 'package:province_district_city_pick/screens/drop_down/model/province.dart';
import 'package:province_district_city_pick/screens/drop_down/utils/fake_json.dart';

///Throws API Exception On Error
class DropDownRepository{
  Future<List<Province>> getDataFromServer() async{
    await Future.delayed(Duration(seconds: Random().nextInt(3)+1));
    bool error =Random().nextInt(10)==0;
    if(error) throw APIException();
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
