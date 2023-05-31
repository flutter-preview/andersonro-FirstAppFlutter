import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ListViewVerticalPage extends StatefulWidget {
  const ListViewVerticalPage({Key? key}) : super(key: key);

  @override
  State<ListViewVerticalPage> createState() => _ListViewVerticalPageState();
}

class _ListViewVerticalPageState extends State<ListViewVerticalPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImagens.Icone1),
          title: Text("Icone 1"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("subtitle"),
              Text("11:11"),
            ],
          ),
          trailing: Icon(Icons.menu),
        ),
        ListTile(
          leading: Image.asset(AppImagens.Icone2),
          title: Text("Icone 2"),
          subtitle: Text("subtitle"),
          //trailing: Icon(Icons.menu),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              print(menu);
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(
                    value: "menu1",
                    child: Text("Menu 1")
                ),
                PopupMenuItem(
                  value: "menu2",
                  child: Text("Menu 2")
                ),
              ];
            },
          ),
        ),
        Image.asset(AppImagens.Icone1),
        Image.asset(AppImagens.Icone2),
        Image.asset(AppImagens.Icone3),
        Image.asset(AppImagens.Icone4),
      ],
    );
  }
}
