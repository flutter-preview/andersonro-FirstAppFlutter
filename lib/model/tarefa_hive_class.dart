import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'tarefa_hive_class.g.dart';

@HiveType(typeId: 1)
class TarefaHiveModel extends HiveObject {

  @HiveField(0)
  String id = UniqueKey().toString();

  @HiveField(1)
  String descricao = "";

  @HiveField(2)
  bool concluido = false;

  TarefaHiveModel.empty();

  TarefaHiveModel(this.descricao, this.concluido);

}