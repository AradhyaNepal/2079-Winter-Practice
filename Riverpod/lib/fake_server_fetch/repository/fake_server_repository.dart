import 'dart:math';

import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';

class FakeServerRepository{
  Future<List<FakeData>> getData(int length)async{
    await Future.delayed(Duration(seconds: Random().nextInt(3)+1));
    bool hasError=Random().nextInt(5)==0;
    if(hasError) throw randomStringGenerator(min: 100, max: 200);
    List<FakeData> fakeData=[];
    for (int i=0;i<length;i++){
      fakeData.add(
          FakeData(
              id: i+1,
              title: randomStringGenerator(min:4,max:8),
              content: randomStringGenerator(min:20,max:50),
              checked: Random().nextBool(),
          )
      );
    }
    return fakeData;
  }

  String letters="abcdefghijklmnoqrstuvwxys";
  String numbers="1234567890";
  String randomStringGenerator({required int min,required int max}){
    String value="";
    int length=Random().nextInt(max)+min;
    for (int i=0;i<length;i++){
      String randomLetter=letters[Random().nextInt(letters.length)];
      String randomNumber=letters[Random().nextInt(letters.length)];
      bool chooseNumber=i!=0 && Random().nextInt(min)==0;
      bool addSpace=i!=0 && Random().nextInt(min*2)==0;
      value+=addSpace?" ":"";
      value+=chooseNumber?randomNumber:randomLetter;
    }
    return value;
  }
}
