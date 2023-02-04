
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/individual_provider.dart';

import 'delete_dialog_widget.dart';

class IndividualDataWidget extends ConsumerStatefulWidget {
  final FakeData data;
  const IndividualDataWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<IndividualDataWidget> createState() => _IndividualDataWidgetState();
}

class _IndividualDataWidgetState extends ConsumerState<IndividualDataWidget> {
  final titleController=TextEditingController();
  final contentController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool editable=false;


  void _getEditable(){
    editable=ref.watch(individualProviderIsEditable);
  }


  @override
  Widget build(BuildContext context) {
    _getEditable();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      editable?
                      TextFormField(
                        controller: titleController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Title";
                          }
                          return null;
                        },
                      )
                          :Text(
                        widget.data.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      editable?
                      TextFormField(
                        controller: contentController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Content";
                          }
                          return null;
                        },
                      )
                          :Text(
                        widget.data.content,
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(editable){
                      if(formKey.currentState!.validate()){
                        ref.read(localDataProvider.notifier).edit(
                          widget.data.copyWith(
                            title: titleController.text,
                            content: contentController.text,
                          ),
                        );
                        titleController.text="";
                        contentController.text="";
                      toggleEditable(editable);
                      }
                    }else{
                      titleController.text=widget.data.title;
                      contentController.text=widget.data.content;
                      toggleEditable(editable);
                    }


                  },
                  child: Icon(
                      ref.watch(individualProviderIsEditable)?Icons.done:Icons.edit
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: () async{
                    final delete=await showDialog(
                        context: context,
                        builder: (context){
                          return const DeleteDataDialog();
                        },
                    );
                    if(delete==true){
                      ref.read(localDataProvider.notifier).delete(widget.data.id);
                      if(!mounted)return;
                      ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text("Deleted")));
                    }
                  },
                  child: const Icon(
                      Icons.delete,
                  ),
                )
            ),
            editable?const SizedBox():Expanded(
              child: Checkbox(
                value:ref.watch(localDataProvider.notifier).isChecked(widget.data.id),
                onChanged: (value){
                  ref.read(localDataProvider.notifier).toggleChecked(widget.data.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleEditable(bool editable) {
    ref.read(individualProviderIsEditable.notifier).state=!editable;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}

