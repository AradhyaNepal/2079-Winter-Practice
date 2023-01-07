
class InternetException with Exception{

  @override
  String toString(){
    return "Cannot connect to internet";
  }
}