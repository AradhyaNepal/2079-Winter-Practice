import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/counter_page/provider/counter_provider.dart';
import 'package:riverpod_practice/counter_page/widgets/add_floating_button.dart';

class CounterPage extends StatelessWidget {
  static const String route="/CounterPage";
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


