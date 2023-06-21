import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/busca_cep_page.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/images_page.dart';
import 'package:trilhaapp/pages/list_view_h_page.dart';
import 'package:trilhaapp/pages/list_view_v_page.dart';
import 'package:trilhaapp/pages/tarefa_sqlite_page.dart';
import 'package:trilhaapp/shared/widgets/drawer_custon.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int positionPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Meu App")),
        drawer: DrawerCuston(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    positionPage = value;
                  });
                },
                children: [
                  //const TesteHttpPage(),
                  const BuscaCepPage(),
                  const CardPage(),
                  Container(
                    color: Colors.blue,
                  ),
                  const ImagensPage(),
                  const ListViewHorizontalPage(),
                  const ListViewVerticalPage(),
                  const TarefaSQLitePage(),
                ],
              ),
            ),
            BottomNavigationBar(
                onTap: (value) {
                  pageController.jumpToPage(value);
                },
                currentIndex: positionPage,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem> [
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: "CEP"),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Page 1"),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: "Page 2"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Page 3"),
                  BottomNavigationBarItem(icon: Icon(Icons.image), label: "Page 4"),
                  BottomNavigationBarItem(icon: Icon(Icons.list), label: "Page 5"),
                  BottomNavigationBarItem(icon: Icon(Icons.add_task), label: "Tarefas"),
                ]
            )
          ],
        ),
      ),
    );
  }
}
