
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/individual_data_widget.dart';

class DataListWidget extends ConsumerWidget {
  const DataListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final serverStatus=ref.watch(serverDataProvider);
    if(serverStatus.isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(serverStatus.hasError){
      // ignore: avoid_print
      print(serverStatus.stackTrace.toString());
      return Center(
        child: TextButton(
          onPressed: (){
            ref.invalidate(serverDataProvider);
          },
          child: Text(
            "${serverStatus.error} \nTap To Load Again!",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else{
      final localValue=ref.watch(filterDataProvider);
      return RefreshIndicator(
        onRefresh: ()async{
          ref.invalidate(serverDataProvider);
          ref.read(filterProvider.notifier).state=SelectedFilter.all;
        },
        child: ListView.builder(
          itemCount: localValue.length,
          itemBuilder: (context,index){
            return IndividualDataWidget(data: localValue[index],);
          },
        ),
      );
    }
  }
}
