import 'package:flutter/cupertino.dart';
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

  DropDownSelectProvider({required List<Province> provinceList}):_provinceList=provinceList;

  void selectProvince(int provinceIndex){
    _selectedProvinceIndex=provinceIndex;
    _selectedDistrictOfProvinceIndex=nothingSelected;
    _selectedCityOfDistrictIndex=nothingSelected;
    notifyListeners();

  }
  void selectDistrict(int districtIndex){
    _selectedDistrictOfProvinceIndex=districtIndex;
    _selectedCityOfDistrictIndex=nothingSelected;
    notifyListeners();
  }
  void selectCity(int cityIndex){
    _selectedCityOfDistrictIndex=cityIndex;
    notifyListeners();
  }

  void showValueButtonPressed(){
    _displayValue=_getValue();
    notifyListeners();
  }

  String _getValue(){
    if(selectedProvinceIndex==-1){
      return "Please Pick Province";
    }
    else if(selectedDistrictIndex==-1){
      return "Please Pick District";
    }
    else if(selectedCityIndex==-1){
      return "Please Pick City";
    }
    Province province=_provinceList[selectedProvinceIndex];
    District district=province.districtList[selectedDistrictIndex];
    City city=district.cityList[selectedCityIndex];
    return "Province: ${province.name}, District: ${district.name}, City: ${city.name}";
  }
}