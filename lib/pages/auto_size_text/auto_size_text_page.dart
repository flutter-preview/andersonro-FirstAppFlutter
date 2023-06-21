import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AutoSizeTextPage extends StatefulWidget {
  const AutoSizeTextPage({super.key});

  @override
  State<AutoSizeTextPage> createState() => _AutoSizeTextPageState();
}

class _AutoSizeTextPageState extends State<AutoSizeTextPage> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Auto Size Text"),),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                TextField(
                  controller: textController,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Card(
                    child: AutoSizeText(textController.text, maxLines: 3,),
                    elevation: 10,
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
