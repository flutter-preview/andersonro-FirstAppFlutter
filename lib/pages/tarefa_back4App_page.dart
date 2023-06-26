import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositores/tarefas_back4app_repository.dart';

class TarefaBack4AppPage extends StatefulWidget {
  const TarefaBack4AppPage({Key? key}) : super(key: key);

  @override
  State<TarefaBack4AppPage> createState() => _TarefaBack4AppPageState();
}

class _TarefaBack4AppPageState extends State<TarefaBack4AppPage> {

  TarefasBack4AppRepository tarefasBack4AppRepository = TarefasBack4AppRepository();
  var descricaoController = TextEditingController();
  var _tarefas = TarefasBack4AppModel();
  bool fgNaoConcluidas = false;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    loadTarefas();
  }

  void loadTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefas = await tarefasBack4AppRepository.getTarefas(fgNaoConcluidas);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas Back4App"),),
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
                          await tarefasBack4AppRepository.save(
                            TarefaBack4AppModel.create(descricaoController.text, false)
                          );
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

            carregando ?
            CircularProgressIndicator() :
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  loadTarefas();
                },
                child: ListView.builder(
                    itemCount: _tarefas.results.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _tarefas.results[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          await tarefasBack4AppRepository.remover(tarefa);
                          loadTarefas();
                        },
                        key: Key(tarefa.objectId.toString()),

                        child: ListTile(
                          title: Text(tarefa!.descricao!),
                          trailing: Switch(
                            onChanged: (bool value) async {
                              tarefa.concluido = value;
                              await tarefasBack4AppRepository.update(tarefa);
                              loadTarefas();
                            },
                            value: tarefa!.concluido!,
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
