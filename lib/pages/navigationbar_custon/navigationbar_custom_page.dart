import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/pages/brasil_fields_page.dart';
import 'package:trilhaapp/pages/contador_getx_page.dart';
import 'package:trilhaapp/pages/contador_mobx_page.dart';
import 'package:trilhaapp/pages/contador_page.dart';
import 'package:trilhaapp/pages/tarefa_provide_page.dart';
import 'package:trilhaapp/service/contador_getx_controller.dart';
import 'package:trilhaapp/service/dark_mode_service.dart';
import 'package:trilhaapp/service/tarefa_provider_repository.dart';

class NavigationBarCustom extends StatefulWidget {
  const NavigationBarCustom({super.key});

  @override
  State<NavigationBarCustom> createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom>
    with TickerProviderStateMixin {
  late TabController tabController;
  int positionPage = 0;
  double qtdMessage = 9;
  var contadorGetXController = ContadorGetXController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    var darkModeService = Provider.of<DarkModeService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nav Bar Custom"),
          actions: [
            Center(child: Text("Dark mode")),
            Consumer<DarkModeService>(
              builder: (builder, darkModeService, widget) {
                return Switch(
                    value: darkModeService.darkMode,
                    onChanged: (bool value) {
                      darkModeService.darkMode = value;
                    }
                );
              }
            )
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ContadorPage(),
            TarefaProvidePage(),
            ContadorMobxPage(),
            Container(
              color: Colors.grey,
              child: Center(
                  child: Column(
                children: [
                  Text(qtdMessage.toString()),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        qtdMessage++;
                      });
                    },
                    child: Text("Add"),
                  )
                ],
              )),
            ),
            BrasilFieldsPage(),
            ContadorGetXPage(),
          ],
        ),
        bottomNavigationBar: Consumer<TarefaProviderRepository>(
          builder: (buider, tarefaProviderRepository, widget) {
            return ConvexAppBar.badge(
              {
                0: '9+',
                1: tarefaProviderRepository.getTarefasNaoConcluidas().toString(),
                2: Colors.amber,
                3: qtdMessage.toString(),
                4: Colors.blue,
                5: Colors.red
              },
              items: const [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.task, title: 'Tarefas'),
                TabItem(icon: Icons.add, title: 'Add'),
                TabItem(icon: Icons.message, title: 'Message'),
                TabItem(icon: Icons.comment_bank_outlined, title: 'Fields BR'),
                TabItem(icon: Icons.calculate_outlined, title: 'GetX'),
              ],
              onTap: (int i) => tabController.index = i,
              controller: tabController,
            );
          }
        ),
      ),
    );
  }
}
