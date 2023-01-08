class City{
  String name;
  City({required this.name});

  static List<City> getListOfCity(List listMap){
    return listMap.map((e) => City(name: e)).toList();
  }
}