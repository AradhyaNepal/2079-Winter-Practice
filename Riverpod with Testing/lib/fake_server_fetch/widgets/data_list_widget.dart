
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/individual_data_widget.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/individual_provider.dart';

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
        child: CustomErrorWidget(serverStatus: serverStatus),
      );
    }else{
      final localValue=ref.watch(filterDataProvider);
      if(localValue.isEmpty){
        return const Center(
          child: Text(
            "No Data available"
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: ()async{
          ref.invalidate(serverDataProvider);
          ref.read(filterProvider.notifier).state=SelectedFilter.all;
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: localValue.length,
          itemBuilder: (context,index){
            return ProviderScope(
                key: ValueKey(localValue[index].id),
                overrides: [
                  individualProviderIsEditable.overrideWith((ref) => false),
                ],
                child: IndividualDataWidget(data: localValue[index],)
            );
          },
        ),
      );
    }
  }
}

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({
    Key? key,
    required this.serverStatus,
  }) : super(key: key);

  final AsyncValue<List<FakeData>> serverStatus;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextButton(
      onPressed: (){
        ref.invalidate(serverDataProvider);
      },
      child: Text(
        "${serverStatus.error} \nTap To Load Again!",
        textAlign: TextAlign.center,
      ),
    );
  }
}
