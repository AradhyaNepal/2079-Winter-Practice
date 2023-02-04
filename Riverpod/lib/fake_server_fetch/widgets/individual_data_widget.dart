
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';

class IndividualDataWidget extends StatelessWidget {
  final FakeData data;
  const IndividualDataWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.content,
                    ),
                  ],
                )
            ),
            Expanded(
                child: Consumer(
                  builder: (context,ref,child) {
                    return Checkbox(
                      value:ref.watch(localDataProvider.notifier).isChecked(data.id),
                      onChanged: (value){
                        ref.read(localDataProvider.notifier).toggleChecked(data.id);
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}