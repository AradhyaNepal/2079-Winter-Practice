import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkSendPage extends StatefulWidget {
  static const String route="/DynamicLinkSend";
  const DynamicLinkSendPage({Key? key}) : super(key: key);

  @override
  State<DynamicLinkSendPage> createState() => _DynamicLinkSendPageState();
}

class _DynamicLinkSendPageState extends State<DynamicLinkSendPage> {
  final formKey=GlobalKey<FormState>();
  String name="",phone="";
  String? generatedLink;
  bool generatingLink=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Link Send"),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value)=>name=value??"",
                    initialValue: "Name",
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    onSaved: (value)=>phone=value??"",
                    initialValue: "Phone",
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Phone";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  generatingLink?
                  const Center(
                    child: CircularProgressIndicator(),
                  ):
                  ElevatedButton(
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          formKey.currentState?.save();
                          _toggleGeneratingLink();
                          //Todo: Generate Link With Details
                          generatedLink=await Future.delayed(Duration.zero);
                          _toggleGeneratingLink();
                        }
                      },
                      child: const Text(
                        "Generate"
                      ),
                  ),
                  const SizedBox(height: 10,),
                  GeneratedLink(
                    generatedLink: generatedLink,
                    generatingLink: generatingLink,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleGeneratingLink() {
    setState(() {
      generatingLink=!generatingLink;
    });
  }
}

///Displays noting if generated link is empty
class GeneratedLink extends StatelessWidget {
  final String? generatedLink;
  final bool generatingLink;
  const GeneratedLink({
    required this.generatingLink,
    required this.generatedLink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if(generatedLink==null || generatingLink)return const SizedBox();
    return Column(
      children: [
        Row(
          children: [
            TextFormField(
              enabled: false,
              initialValue: generatedLink,
            ),
            const SizedBox(width: 5,),
            IconButton(
                onPressed: ()async{
                  final scaffoldMessenger=ScaffoldMessenger.of(context);
                  await Clipboard.setData(ClipboardData(text: generatedLink));
                  scaffoldMessenger..removeCurrentSnackBar()..showSnackBar(
                    const SnackBar(
                        content: Text(
                          "Successfully Copied"
                        ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.copy,
                ),
            )
          ],
        ),
        const SizedBox(height: 10,),
        ElevatedButton(
            onPressed: (){
              Share.share(generatedLink??"NULL");
            },
            child: const Text(
              "Share",
            ),
        )

      ],
    );
  }
}
