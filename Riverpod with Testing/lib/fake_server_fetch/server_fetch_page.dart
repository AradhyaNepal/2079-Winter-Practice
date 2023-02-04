import 'package:flutter/material.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/data_list_widget.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/filter_widget.dart';

class ServerFetchPage extends StatelessWidget {
  static const String route="/ServerFetch";
  const ServerFetchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Server Fetch",
            ),
          ),
          body: Column(
            children: const[
              ChooseFilterWidget(),
              SizedBox(height: 10,),
              Expanded(
                  child:DataListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
