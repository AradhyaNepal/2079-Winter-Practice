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
        appBar: AppBar(
          title: const Text("Counter"),
        ),
        body: Center(
          child: Consumer(
            builder: (context,ref,child) {
              int value=ref.watch(counterProvider);
              bool inDangerZone=value<=-10 || value>=10;
              return Text(
                  value.toString(),
                style: inDangerZone?
                const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ):null,
              );
            }
          ),
        ),
        floatingActionButton: const CustomFloatingActionButton(),
      ),
    );
  }
}


