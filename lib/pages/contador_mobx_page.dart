import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trilhaapp/service/contato_mobx_service.dart';

class ContadorMobxPage extends StatelessWidget {
  ContadorMobxPage({super.key});
  ContadorMobxService contadorMobxService = ContadorMobxService();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (builder) {
              return Text(
                "Contador: ${contadorMobxService.contador}",
                style: const TextStyle(fontSize: 20),
              );
            }
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1, color: Colors.blue),
            ),
            onPressed: () {
              contadorMobxService.incrementar();
            },
            child: Text("Incrementar"),

          )
        ],
      ),
    );
  }
}
