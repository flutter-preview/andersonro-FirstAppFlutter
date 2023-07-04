import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/service/contador_service.dart';

class ContadorPage extends StatelessWidget {
  const ContadorPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ContadorService>(
            builder: (builder, contadorService, widget) {
              return Text(
                "Contador: ${contadorService.contador}",
                style: const TextStyle(
                  fontSize: 20
                ),
              );
            }
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1, color: Colors.blue),
            ),
            onPressed: () {
              Provider.of<ContadorService>(context, listen: false).increment();
            },
            child: Text("Incrementar"),

          )
        ],
      ),
    );
  }
}
