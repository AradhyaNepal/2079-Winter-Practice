
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';

class ChooseFilterWidget extends StatelessWidget {
  const ChooseFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _IndividualFilterUnit(filterType: SelectedFilter.all,),
        SizedBox(width: 5,),
        _IndividualFilterUnit(filterType: SelectedFilter.checked,),
        SizedBox(width: 5,),
        _IndividualFilterUnit(filterType: SelectedFilter.unchecked,),
      ],
    );
  }
}

class _IndividualFilterUnit extends ConsumerWidget {
  final SelectedFilter filterType;
  const _IndividualFilterUnit({
    required this.filterType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedFilter=ref.watch(filterProvider);
    return Expanded(
      child: GestureDetector(
        onTap: (){
          ref.read(filterProvider.notifier).state=filterType;
        },
        child: Text(
            getText,
          textAlign: TextAlign.center,
          style:selectedFilter==filterType?
          const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ):null,
        ),
      ),
    );
  }

  String get getText{
    switch(filterType){
      case SelectedFilter.checked:
        return "Checked";
      case SelectedFilter.unchecked:
        return "UnChecked";
      case SelectedFilter.all:
        return "All";
    }
  }
}
