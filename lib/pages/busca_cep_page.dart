import 'package:flutter/material.dart';
import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:trilhaapp/repositores/cep/cep_repository.dart';
import 'package:trilhaapp/repositores/cep/impl/cep_dio_repository.dart';

class BuscaCepPage extends StatefulWidget {
  const BuscaCepPage({super.key});

  @override
  State<BuscaCepPage> createState() => _BuscaCepPageState();
}

class _BuscaCepPageState extends State<BuscaCepPage> {

  var cepController = TextEditingController(text: '');
  bool isLoading = false;
  var viaCepModel = ViaCepModel();
  CepRepository viaCepRepository = CepDioRepository();
  var cepNaoEncontrado = '';

  void buscaViaCep(String cep) async {
    setState(() {
      isLoading = true;
    });
    viaCepModel = await viaCepRepository.getCep(cep);
    if (viaCepModel.logradouro == null) cepNaoEncontrado = 'Cep não encontrado!';
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(child: Text("Consulta CEP")),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              onChanged: (String value) {
                buscaViaCep(value);
              },
            ),
            Center(child: Text(viaCepModel.logradouro ?? cepNaoEncontrado)),
            if(viaCepModel.localidade != null) Center(child: Text("${viaCepModel.localidade ?? ""} - ${viaCepModel.uf ?? ""}")),
            Visibility(
              visible: isLoading,
                child: const CircularProgressIndicator()
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: (){}
      ),
    ));
  }
}
