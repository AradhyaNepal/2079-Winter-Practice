import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/counter_page/provider/counter_provider.dart';

class CustomFloatingActionButton extends ConsumerWidget {
  const CustomFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return FloatingActionButton(
      onPressed: (){
        ref.read(counterProvider.notifier).state++;
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}