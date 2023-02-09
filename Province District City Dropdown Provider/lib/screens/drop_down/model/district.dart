import 'package:province_district_city_pick/screens/drop_down/model/city.dart';

class District{
  String name;
  List<City> cityList;

  District({
    required this.name,
    required this.cityList,
  });

  factory District.fromMap(Map<String,dynamic> map){
    return District(
      name: map["district"],
      cityList: City.getListOfCity(map["cities"]),
    );
  }

  static List<District> getListOfDistrict(List mapList){
    return mapList.map((e) => District.fromMap(e)).toList();
  }

}