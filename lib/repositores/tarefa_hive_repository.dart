import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa_hive_class.dart';

class TarefaHiveRepository {

  static late Box _box;
  static const String _BOX_NAME = "TAREFA";

  TarefaHiveRepository._create();

  static Future<TarefaHiveRepository> load() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
      print("TarefaHiveRepository: 1");
    } else {
      print("TarefaHiveRepository: 2");
      _box = await Hive.openBox(_BOX_NAME);
    }
    return TarefaHiveRepository._create();
  }

  save(TarefaHiveModel tarefaHiveModel) {
    _box.add(tarefaHiveModel);
  }

  edit(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  delete(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }

  List<TarefaHiveModel> loadData(bool naoConcluidos) {
    if (naoConcluidos) {
      return _box.values.cast<TarefaHiveModel>().where((element) => !element.concluido).toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }
}