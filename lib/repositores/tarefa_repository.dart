import '../model/tarefa_class.dart';

class TarefaRepository {

  final List<Tarefa> _tarefas = [];

  Future<void> addTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 5));
    _tarefas.add(tarefa);
  }

  Future<void> concluirTarefa(String id, bool concluido) async {
    await Future.delayed(const Duration(seconds: 5));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido;
  }

  Future<void> removeTarefa(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Tarefa>> listarTarefas({bool fgNaoConcluidas = false}) async {
    await Future.delayed(const Duration(seconds: 5));
    var tarefas = _tarefas;
    if(fgNaoConcluidas) {
      tarefas = _tarefas.where((tarefa) => !tarefa.concluido).toList();
    }
    return tarefas;
  }

}