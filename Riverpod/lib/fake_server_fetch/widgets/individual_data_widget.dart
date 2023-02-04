
import 'package:flutter/material.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';

class IndividualDataWidget extends StatelessWidget {
  final FakeData data;
  const IndividualDataWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Hello");
  }
}