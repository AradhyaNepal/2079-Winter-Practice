import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';

String getTextFromEnum(SelectedFilter filter){
  switch(filter){
    case SelectedFilter.checked:
      return "Checked";
    case SelectedFilter.unchecked:
      return "UnChecked";
    case SelectedFilter.all:
      return "All";
  }
}