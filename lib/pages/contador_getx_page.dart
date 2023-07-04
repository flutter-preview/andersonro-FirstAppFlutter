import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:trilhaapp/main.dart';
import 'package:trilhaapp/service/contador_getx_controller.dart';
import 'package:trilhaapp/service/contato_mobx_service.dart';

class ContadorGetXPage extends StatelessWidget {
  ContadorGetXPage({super.key});

  var contadorGetXController = getIt.get<ContadorGetXController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Contador GetX"),
          Obx(() => Text(
              "Contador: ${contadorGetXController.contador}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1, color: Colors.blue),
            ),
            onPressed: () {
              contadorGetXController.incrementar();
            },
            child: Text("Incrementar"),
          )
        ],
      ),
    );
  }
}
