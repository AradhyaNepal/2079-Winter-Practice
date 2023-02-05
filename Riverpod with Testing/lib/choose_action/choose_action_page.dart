import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/choose_action/widgets/custom_select_page_button.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';
import 'package:riverpod_practice/counter_page/provider/counter_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';

class ChooseActionPage extends StatelessWidget {
  static const String route="/";
  const ChooseActionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          appBar:AppBar(
            title: const Text("Riverpod Practice"),
          ),
          body: Column(
            children:[
              Expanded(
                child:Consumer(
                    builder: (context,ref,child) {
                      return CustomSelectPageButton(
                        extraTaskBeforeGoing: (){
                          ref.invalidate(counterProvider);
                        },
                        whichPageToGo: CounterPage.route,
                      );
                    }
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context,ref,child) {
                    return CustomSelectPageButton(
                      extraTaskBeforeGoing: (){
                        ref.invalidate(filterProvider);
                        ref.invalidate(serverDataProvider);
                      },
                      whichPageToGo: ServerFetchPage.route,
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
