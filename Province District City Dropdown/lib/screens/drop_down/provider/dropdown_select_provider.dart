import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:province_district_city_pick/screens/drop_down/model/city.dart';
import 'package:province_district_city_pick/screens/drop_down/model/district.dart';
import 'package:province_district_city_pick/screens/drop_down/model/province.dart';

class DropDownSelectProvider with ChangeNotifier{
  final List<Province> _provinceList;
  static const int nothingSelected=-1;
  int _selectedProvinceIndex=nothingSelected;
  int _selectedDistrictOfProvinceIndex=nothingSelected;
  int _selectedCityOfDistrictIndex=nothingSelected;
  ///-1 Means Nothing Selected
  int get selectedProvinceIndex=>_selectedProvinceIndex;
  ///-1 Means Nothing Selected
  int get selectedDistrictIndex=>_selectedDistrictOfProvinceIndex;
  ///-1 Means Nothing Selected
  int get selectedCityIndex=>_selectedCityOfDistrictIndex;

  String _displayValue="";
  String get displayValue=>_displayValue;


  List<DropdownMenuItem<int>> get provinceDropDown{
    List<DropdownMenuItem<int>> list=[
      const DropdownMenuItem<int>(
        value: nothingSelected,
        child: Text("Select Province"),
      ),
    ];
    for(int i=0;i<_provinceList.length;i++){
      list.add(
        DropdownMenuItem(
          value: i,
          child: Text(_provinceList[i].name),
        )
      );
    }
    return list;
  }

  List<DropdownMenuItem<int>> get districtDropDown{
    List<DropdownMenuItem<int>> list=[
      const DropdownMenuItem<int>(
        value: nothingSelected,
        child: Text("Select District"),
      ),
    ];

    for(int i=0;i<districtList.length;i++){
      list.add(
          DropdownMenuItem(
            value: i,
            child: Text(districtList[i].name),
          )
      );
    }
    return list;
  }

  List<District> get districtList {
    if(selectedProvinceIndex==-1)return [];
    return _provinceList[selectedProvinceIndex].districtList;
  }

  List<DropdownMenuItem<int>> get cityDropDown{
    List<DropdownMenuItem<int>> list=[
      const DropdownMenuItem<int>(
        value: nothingSelected,
        child: Text("Select City"),
      ),
    ];
    for(int i=0;i<cityList.length;i++){
      list.add(
          DropdownMenuItem(
            value: i,
            child: Text(cityList[i].name),
          )
      );
    }
    return list;
  }

  List<City> get cityList {
    if(selectedDistrictIndex==-1)return[];
    return districtList[selectedDistrictIndex].cityList;
  }

  DropDownSelectProvider({required List<Province> provinceList}):_provinceList=provinceList;

  void selectProvince(int? provinceIndex){
    _selectedProvinceIndex=provinceIndex??nothingSelected;
    _selectedDistrictOfProvinceIndex=nothingSelected;
    _selectedCityOfDistrictIndex=nothingSelected;
    notifyListeners();

  }
  void selectDistrict(int? districtIndex){
    _selectedDistrictOfProvinceIndex=districtIndex??nothingSelected;
    _selectedCityOfDistrictIndex=nothingSelected;
    notifyListeners();
  }
  void selectCity(int? cityIndex){
    _selectedCityOfDistrictIndex=cityIndex??nothingSelected;
    notifyListeners();
  }

  void showValueButtonPressed(){
    _displayValue=_getValue();
    notifyListeners();
  }

  String _getValue(){
    if(selectedProvinceIndex==nothingSelected){
      return "Please Pick Province";
    }
    else if(selectedDistrictIndex==nothingSelected){
      return "Please Pick District";
    }
    else if(selectedCityIndex==nothingSelected){
      return "Please Pick City";
    }
    Province province=_provinceList[selectedProvinceIndex];
    District district=province.districtList[selectedDistrictIndex];
    City city=district.cityList[selectedCityIndex];
    return "Province: ${province.name}, District: ${district.name}, City: ${city.name}";
  }
}