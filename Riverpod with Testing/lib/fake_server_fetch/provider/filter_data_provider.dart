import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';

enum SelectedFilter{
  checked,
  unchecked,
  all,
}

final filterProvider=StateProvider<SelectedFilter>((ref) => SelectedFilter.all);


final filterDataProvider=Provider<List<FakeData>>((ref){
  final localData=ref.watch(localDataProvider) as List<FakeData>;
  final selectedFilter=ref.watch(filterProvider);
  switch(selectedFilter){
    case SelectedFilter.checked:
      return localData.where((element) => element.checked).toList();
    case SelectedFilter.unchecked:
      return localData.where((element) => !element.checked).toList();
    case SelectedFilter.all:
      return localData;
  }
});