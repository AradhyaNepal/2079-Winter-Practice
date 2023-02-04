import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';

final similarTitleCountProvider=Provider.family<String,String>((ref,title) {
  final localData=ref.watch(filterDataProvider);
  final filterType=ref.watch(filterProvider);
  int count=localData.where((element) => element.title==title).length;
  switch(filterType){
    case SelectedFilter.all:
      return "Same Title : $count";
    case SelectedFilter.checked:
      return "Same Checked Title : $count";
    case SelectedFilter.unchecked:
      return "Same Unchecked Title : $count";
  }

});