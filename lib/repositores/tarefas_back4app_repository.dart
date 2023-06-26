import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/repositores/back4app_custon_dio.dart';

import '../model/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {

  var _dio = Back4AppCustonDio();

  TarefasBack4AppRepository() {}

  Future<TarefasBack4AppModel> getTarefas(bool fgNaoConcluidas) async {
    var url = "/Tarefas";

    if (fgNaoConcluidas) {
      url = "$url?where={\"concluido\":false}";
    }

    var result = await _dio.dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> save(TarefaBack4AppModel TarefaBack4AppModel) async {
    try {
      var response = await _dio.dio.post("/Tarefas", data: TarefaBack4AppModel.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      var response = await _dio.dio.put("/Tarefas/${tarefaBack4AppModel.objectId}", data: tarefaBack4AppModel.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      var response = await _dio.dio.delete("/Tarefas/${tarefaBack4AppModel.objectId}");
    } catch (e) {
      throw e;
    }
  }
}