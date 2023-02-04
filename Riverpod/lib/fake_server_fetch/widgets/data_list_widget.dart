
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/individual_data_widget.dart';

class DataListWidget extends ConsumerWidget {
  const DataListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final data=ref.watch(serverDataProvider);
    if(data.isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(data.hasError){
      // ignore: avoid_print
      print(data.stackTrace.toString());
      return Center(
        child: TextButton(
          onPressed: (){
            ref.invalidate(serverDataProvider);
          },
          child: Text(
            "${data.error} \nTap To Load Again!",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else{
      final value=data.value??[];
      return RefreshIndicator(
        onRefresh: ()async{
          ref.invalidate(serverDataProvider);
        },
        child: ListView.builder(
          itemCount: value.length,
          itemBuilder: (context,index){
            return IndividualDataWidget(data: value[index],);
          },
        ),
      );
    }
  }
}
