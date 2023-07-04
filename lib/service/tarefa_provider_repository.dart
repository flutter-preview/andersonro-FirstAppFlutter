import 'package:flutter/foundation.dart';
import 'package:trilhaapp/model/tarefa_class.dart';

class TarefaProviderRepository extends ChangeNotifier {
  final _tarefas = <Tarefa>[];
  bool _apenasNaoConluidos = false;

  bool get apenasNaoConluidos => _apenasNaoConluidos;

  set apenasNaoConluidos(bool value) {
    _apenasNaoConluidos = value;
    notifyListeners();
  }

  get tarefas => _apenasNaoConluidos
      ? _tarefas.where((element) => !element.concluido).toList()
      : _tarefas;

  addTarefa(Tarefa tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  editTarefa(Tarefa tarefa) {
    _tarefas.where((element) => element.id == tarefa.id).first.concluido =
        tarefa.concluido;
    notifyListeners();
  }

  delTarefa(Tarefa tarefa) {
    _tarefas.remove(tarefa);
    notifyListeners();
  }

  int getTarefasNaoConcluidas() {
    return _tarefas.where((element) => element.concluido == false).toList().length;
    notifyListeners();
  }
}
