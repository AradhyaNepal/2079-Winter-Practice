import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/counter_page/provider/counter_provider.dart';

class CustomFloatingActionButton extends ConsumerWidget {
  const CustomFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.listen(counterProvider, (previous, next) {
      if(next==10 && (previous??0)<10){
        ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Value Too High")));
      }else if(next==-10 && (previous??0)>-10){
        ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Value Too Low")));
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: (){
            ref.read(counterProvider.notifier).update((state){
              if(state<20){
                return ++state;
              }else{
                ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Cannot go further up")));
                return state;
              }

            });
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        const SizedBox(width: 20,),
        FloatingActionButton(
          onPressed: (){
            ref.read(counterProvider.notifier).update((state) {
              if(state>-20){
                return --state;
              }else{
                ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Cannot go further low")));
                return state;
              }
            });
          },
          child: const Icon(
            Icons.remove,
          ),
        ),

      ],
    );
  }
}