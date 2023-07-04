import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BrasilFieldsPage extends StatefulWidget {
  const BrasilFieldsPage({super.key});

  @override
  State<BrasilFieldsPage> createState() => _BrasilFieldsPageState();
}

class _BrasilFieldsPageState extends State<BrasilFieldsPage> {

  var controllerCEP = TextEditingController();
  var controllerCPF = TextEditingController();

  @override
  Widget build(BuildContext  context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cep"),
            TextFormField(
              controller: controllerCEP,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
            ),
            const SizedBox(height: 16,),
            const Text("CPF"),
            TextFormField(
              controller: controllerCPF,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
            ),
            SizedBox(height: 16,),
            TextButton(
                onPressed: () {
                  var f = NumberFormat('#,###.0#', 'en_US');
                  var fBR = NumberFormat('#,###.0#', 'pt_BR');
                  print(f.format(1234.345));
                  print(fBR.format(1234.345));
                },
                child: const Text("Intl")
            )
          ],
        ),
      )
    );
  }
}
