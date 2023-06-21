import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_sqlite_class.dart';
import 'package:trilhaapp/repositores/sqlite/tarefa_sqlite_repository.dart';

class TarefaSQLitePage extends StatefulWidget {
  const TarefaSQLitePage({Key? key}) : super(key: key);

  @override
  State<TarefaSQLitePage> createState() => _TarefaSQLitePageState();
}

class _TarefaSQLitePageState extends State<TarefaSQLitePage> {
  TarefaSQLiteRepository tarefaSQLiteRepository = new TarefaSQLiteRepository();
  var descricaoController = TextEditingController();
  var _tarefas = const <TarefaSQLite>[];
  bool fgNaoConcluidas = false;

  @override
  void initState() {
    super.initState();
    loadTarefas();
  }

  void loadTarefas() async {
    _tarefas = await tarefaSQLiteRepository.getTarefas();
    //_tarefas = tarefaHiveRepository.loadData(fgNaoConcluidas);
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
                  title: const Text("Cadastro de tarefas"),
                  content: TextField(controller: descricaoController,),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await tarefaSQLiteRepository.insertTarefa(TarefaSQLite(0, descricaoController.text, false));
                          loadTarefas();
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
                  const Text("Filtrar não concluídos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                        tarefaSQLiteRepository.deleteTarefa(tarefa.id);
                        loadTarefas();
                      },
                      key: Key(tarefa.id.toString()),

                      child: ListTile(
                        title: Text(tarefa.descricao),
                        trailing: Switch(
                          onChanged: (bool value) async {
                            tarefa.concluido = value;
                            tarefaSQLiteRepository.updateTarefa(tarefa);
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
