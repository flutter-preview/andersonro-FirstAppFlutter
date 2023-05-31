import 'package:flutter/material.dart';
import 'package:trilhaapp/repositores/languages_repository.dart';
import 'package:trilhaapp/repositores/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController();
  var dataNascimentoController = TextEditingController();
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = "";

  var linguagensRepository = LanguagesRepository();
  var liguagens = [];
  var liguaguensSelecionadas = [];

  double salario_escolido = 0;
  double salario_min = 0;
  double salario_max = 15000.roundToDouble();

  int tempo_experiencia = 0;

  bool salvando = false;

  List<DropdownMenuItem<int>> returnItens(int quantidadeMax) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMax; i++) {
      itens.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    liguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dados cadastrais"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: salvando
              ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(127, 0, 0, 0),
                  ),
              )
              : ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextLabel(texto: "Nome"),
                    TextField(
                      controller: nomeController,
                    ),
                    const TextLabel(texto: "Data de nascimento"),
                    TextField(
                      controller: dataNascimentoController,
                      readOnly: true,
                      onTap: () async {
                        var dataNascimento = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1930, 1, 1),
                            lastDate: DateTime.now());

                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Center(
                              child: Text(
                                "É necessário selecionar a data de nascimento",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            backgroundColor: Color.fromARGB(255, 141, 80, 115),
                          ));
                        } else {
                          dataNascimentoController.text =
                              dataNascimento.toString();
                          dataNascimento = dataNascimento;
                        }
                      },
                    ),
                    const TextLabel(texto: "Experiências"),
                    Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              selected: nivel == nivelSelecionado,
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  nivelSelecionado = value.toString();
                                });
                              }))
                          .toList(),
                    ),
                    const TextLabel(texto: "Liguagens:"),
                    Column(
                      children: liguagens
                          .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem),
                              value: liguaguensSelecionadas.contains(linguagem),
                              onChanged: (bool? onChanged) {
                                setState(() {
                                  if (onChanged!) {
                                    if (!liguaguensSelecionadas
                                        .contains(linguagem))
                                      liguaguensSelecionadas.add(linguagem);
                                  } else {
                                    liguaguensSelecionadas.remove(linguagem);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                    TextLabel(
                        texto:
                            "Pretensão salarial R\$ ${salario_escolido.round().toString()}"),
                    Slider(
                        min: salario_min,
                        max: salario_max,
                        divisions: salario_max.toInt(),
                        label: salario_escolido.toString(),
                        value: salario_escolido,
                        onChanged: (double value) {
                          setState(() {
                            salario_escolido = value;
                          });
                        }),
                    const TextLabel(texto: "Tempo de experiência"),
                    DropdownButton(
                        value: tempo_experiencia,
                        isExpanded: true,
                        items: returnItens(30),
                        onChanged: (value) {
                          setState(() {
                            tempo_experiencia = int.parse(value.toString());
                          });
                        }),
                    TextButton(
                        onPressed: () {
                          print(nomeController.text);
                          print(dataNascimento);
                          print(liguaguensSelecionadas);
                          print(nivelSelecionado);
                          print(tempo_experiencia);

                          setState(() {
                            salvando = true;
                          });

                          Future.delayed(Duration(seconds: 5), () {
                            setState(() {
                              //salvando = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Cadastro salvo com sucesso!!",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    ),
                                    backgroundColor: Color.fromARGB(255, 38, 117, 11),
                                  )
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const DadosCadastraisPage()));
                            });
                          });


                        },
                        child: const Text("Salvar"))
                  ],
                ),
        ),
      ),
    );
  }
}
