import 'package:flutter/material.dart';

import '../shared/widgets/app_images.dart';

class ListViewHorizontalPage extends StatefulWidget {
  const ListViewHorizontalPage({Key? key}) : super(key: key);

  @override
  State<ListViewHorizontalPage> createState() => _ListViewHorizontalPageState();
}

class _ListViewHorizontalPageState extends State<ListViewHorizontalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Image.asset(AppImagens.Icone1),
                ),
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Image.asset(AppImagens.Icone2),
                ),
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Image.asset(AppImagens.Icone3),
                ),
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Image.asset(AppImagens.Icone4),
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }
}
