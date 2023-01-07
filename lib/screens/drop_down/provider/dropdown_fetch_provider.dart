import 'package:flutter/cupertino.dart';
import 'package:province_district_city_pick/constants/exceptions.dart';
import 'package:province_district_city_pick/screens/drop_down/model/province.dart';
import 'package:province_district_city_pick/screens/drop_down/repository/dropdown_repository.dart';

class DropDownFetchProvider with ChangeNotifier{
  bool isLoading=true;
  bool hasError=false;
  String errorMessage="";
  List<Province> provinceList=[];

  DropDownFetchProvider(){
    _loadData();
  }

  void _loadData() async{
    try{
      provinceList=await DropDownRepository().getDataFromServer();
    }on APIException catch(e){
      hasError=true;
      errorMessage=e.toString();
    }
    isLoading=false;
    notifyListeners();
  }
}