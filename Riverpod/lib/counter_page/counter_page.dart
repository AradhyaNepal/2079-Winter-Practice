import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/counter_page/provider/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        body: Center(
          child: Consumer(
            builder: (context,ref,child) {
              return Text(
                ref.watch(stringCounterProvider)
              );
            }
          ),
        ),
        floatingActionButton: const CustomFloatingActionButton(),
      ),
    );
  }
}

class CustomFloatingActionButton extends ConsumerWidget {
  const CustomFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return FloatingActionButton(
      onPressed: (){

      },
      child: Icon(
        Icons.add,
      ),
    );
  }
}
