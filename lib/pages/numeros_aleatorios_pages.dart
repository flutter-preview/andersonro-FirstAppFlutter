import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/shared/widgets/app_prefs.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({Key? key}) : super(key: key);

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;
  late Box box;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    if (Hive.isBoxOpen(AppPrefs.APP_BOX_NUMEROS_ALEATORIOS)) {
      box = Hive.box(AppPrefs.APP_BOX_NUMEROS_ALEATORIOS);
    } else {
      box = await Hive.openBox(AppPrefs.APP_BOX_NUMEROS_ALEATORIOS);
    }
    setState(() {
      numeroGerado = box.get(AppPrefs.APP_BOX_KEY_NUMERO_GERADO) ?? 0;
      quantidadeCliques = box.get(AppPrefs.APP_BOX_KEY_QTD_CLIQUES) ?? 0;
    });
  }

  void numeroAleatorio() async {
    var randon = Random();
    await box.put(AppPrefs.APP_BOX_KEY_NUMERO_GERADO, randon.nextInt(1000));
    await box.put(AppPrefs.APP_BOX_KEY_QTD_CLIQUES, (quantidadeCliques+1));

    setState(() {
      numeroGerado = box.get(AppPrefs.APP_BOX_KEY_NUMERO_GERADO) ?? 0;
      quantidadeCliques = box.get(AppPrefs.APP_BOX_KEY_QTD_CLIQUES) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: ()  {
                numeroAleatorio();
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text("Números Alteatórios"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("O número gerado é: ${numeroGerado}.",
                                  style: const TextStyle(fontSize: 20,),
                            )
              ),
              Center(child: Text("Você clicou: ${quantidadeCliques} vezes.")),
        ],
      ),
    ));
  }
}
