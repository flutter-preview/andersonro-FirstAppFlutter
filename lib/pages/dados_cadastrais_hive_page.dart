import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_class.dart';
import 'package:trilhaapp/repositores/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositores/languages_repository.dart';
import 'package:trilhaapp/repositores/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisHivePage> createState() => _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {

  late DadosCadastraisRepository dadosCadastraisRepositor;
  var dadosCadastraisModel = DadosCadastraisModel.empty();
  var nomeController = TextEditingController();
  var dataNascimentoController = TextEditingController();
  var nivelRepository = NivelRepository();
  var niveis = [];
  var linguagensRepository = LanguagesRepository();
  var linguagens = [];
  double salario_min = 0;
  double salario_max = 15000.roundToDouble();


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
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    loadData();
  }

  loadData() async {
    dadosCadastraisRepositor = await DadosCadastraisRepository.load();
    dadosCadastraisModel = dadosCadastraisRepositor.loadData();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null ? "" : dadosCadastraisModel.dataNascimento.toString();
    //linguagens = dadosCadastraisModel.liguangens ?? [];
    setState(() {});
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
                        var data = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1930, 1, 1),
                            lastDate: DateTime.now());

                        if (data == null) {
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
                          dataNascimentoController.text = data.toString();
                          dadosCadastraisModel.dataNascimento = data;
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
                              selected: nivel == dadosCadastraisModel.nivelExperiencia,
                              groupValue: dadosCadastraisModel.nivelExperiencia,
                              onChanged: (value) {
                                setState(() {
                                  dadosCadastraisModel.nivelExperiencia = value.toString() ?? "";
                                });
                              }))
                          .toList(),
                    ),
                    const TextLabel(texto: "Liguagens:"),
                    Column(
                      children: linguagens
                          .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem),
                              value: dadosCadastraisModel.liguangens.contains(linguagem),
                              onChanged: (bool? onChanged) {
                                setState(() {
                                  if (onChanged!) {
                                    if (!dadosCadastraisModel.liguangens.contains(linguagem))
                                      dadosCadastraisModel.liguangens.add(linguagem);
                                  } else {
                                    dadosCadastraisModel.liguangens.remove(linguagem);
                                  }
                                });
                              }))
                          .toList(),
                    ),
                    TextLabel(
                        texto:
                            "Pretensão salarial R\$ ${dadosCadastraisModel.salario.round().toString()}"),
                    Slider(
                        min: salario_min,
                        max: salario_max,
                        divisions: salario_max.toInt(),
                        label: dadosCadastraisModel.salario.toString(),
                        value: dadosCadastraisModel.salario,
                        onChanged: (double value) {
                          setState(() {
                            dadosCadastraisModel.salario = value ?? 0;
                          });
                        }),
                    const TextLabel(texto: "Tempo de experiência"),
                    DropdownButton(
                        value: dadosCadastraisModel.tempoExperiencia,
                        isExpanded: true,
                        items: returnItens(30),
                        onChanged: (value) {
                          setState(() {
                            dadosCadastraisModel.tempoExperiencia = int.parse(value.toString()) ?? 0;
                          });
                        }),
                    TextButton(
                        onPressed: () {

                          dadosCadastraisModel.nome = nomeController.text;
                          dadosCadastraisRepositor.save(dadosCadastraisModel);

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
                                  builder: (context) => const DadosCadastraisHivePage()));
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
