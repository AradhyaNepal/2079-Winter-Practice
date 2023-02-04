import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_server_repository.dart';

final serverDataProvider=FutureProvider((ref) => FakeServerRepository().getData(Random().nextInt(100)+10));

final localDataProvider=StateNotifierProvider((ref)=>LocalTodoState([]));
class LocalTodoState extends StateNotifier<List<FakeData>>{

  LocalTodoState(List<FakeData> initialData):super(initialData);

  List<FakeData> get list=>state;

  void add(FakeData fakeData){
    state=[...state,fakeData];
  }

  void delete(int id){
    state=[
      for(FakeData value in state)
        if(value.id!=id)
          value
    ];
  }

  void edit(FakeData fakeData){
    state=state.map((e) {
      if(e.id==fakeData.id){
        return fakeData;
      }
      return e;
    }).toList();
  }

  void toggleChecked(int id){
    state=state.map((e) {
      if(e.id==id){
        return e.copyWith(
          checked: !e.checked,
        );
      }
      return e;
    }).toList();
  }


}