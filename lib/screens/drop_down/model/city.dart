class City{
  String name;
  City({required this.name});

  static List<City> getListOfCity(List<String> list){
    return list.map((e) => City(name: e)).toList();
  }
}