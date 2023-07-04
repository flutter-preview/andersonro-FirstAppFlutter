import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/model/tarefa_class.dart';
import 'package:trilhaapp/service/tarefa_provider_repository.dart';

class TarefaProvidePage extends StatelessWidget {

  var descricaoController = TextEditingController();

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
                          await Provider.of<TarefaProviderRepository>(context, listen: false).addTarefa(
                            Tarefa(descricaoController.text, false)
                          );
                          Navigator.pop(context);
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
                  Consumer<TarefaProviderRepository>(
                    builder: (builder, tarefaProvideRepository, Wwidget) {
                      return Switch(
                          value: tarefaProvideRepository.apenasNaoConluidos,
                          onChanged: (bool value) async {
                            Provider.of<TarefaProviderRepository>(context, listen: false).apenasNaoConluidos = value;
                          }
                      );
                    }
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<TarefaProviderRepository>(
                builder: (builder, tarefaProviderRepository, widget) {
                  return ListView.builder(
                      itemCount: tarefaProviderRepository.tarefas.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var tarefa = tarefaProviderRepository.tarefas[index];
                        return Dismissible(
                          onDismissed: (DismissDirection dismissDirection) async {
                            await Provider.of<TarefaProviderRepository>(context, listen: false).delTarefa(tarefa);
                          },
                          key: Key(tarefa.id),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                await Provider.of<TarefaProviderRepository>(context, listen: false).editTarefa(tarefa);
                              },
                              value: tarefa.concluido,
                            ),
                          ),
                        );
                      }
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
