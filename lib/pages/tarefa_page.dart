import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_class.dart';
import 'package:trilhaapp/repositores/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({Key? key}) : super(key: key);

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var descricaoController = TextEditingController();
  var _tarefas = const <Tarefa>[];
  bool fgNaoConcluidas = false;

  @override
  void initState() {
    super.initState();
    loadTarefas();
  }

  void loadTarefas() async {
    _tarefas = await tarefaRepository.listarTarefas(
        fgNaoConcluidas: fgNaoConcluidas
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: Text("Cadastro de tarefas"),
                  content: TextField(controller: descricaoController,),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar")
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await tarefaRepository.addTarefa(Tarefa(descricaoController.text, false));
                          setState(() {});
                        },
                        child: const Text("Salvar")
                    ),
                  ],
                );
              }
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filtrar não concluídos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Switch(
                      value: fgNaoConcluidas,
                      onChanged: (bool value) {
                        fgNaoConcluidas = value;
                        loadTarefas();
                      }
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        await tarefaRepository.removeTarefa(tarefa.id);
                        print("dismissDirection: ${dismissDirection}");
                        loadTarefas();
                      },
                      key: Key(tarefa.id),

                      child: ListTile(
                        title: Text(tarefa.descricao),
                        trailing: Switch(
                          onChanged: (bool value) async {
                            await tarefaRepository.concluirTarefa(tarefa.id, value);
                            loadTarefas();
                          },
                          value: tarefa.concluido,
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
