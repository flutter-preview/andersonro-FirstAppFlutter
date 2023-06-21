import 'package:flutter/cupertino.dart';
import 'package:trilhaapp/model/tarefa_sqlite_class.dart';
import 'package:trilhaapp/repositores/sqlite/sqlite_database.dart';

class TarefaSQLiteRepository {
  
  Future<List<TarefaSQLite>> getTarefas() async {
    List<TarefaSQLite> tarefas = [];
    var db = await SQLiteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT id, descricao, concluido FROM tarefas');
    for (var el in result) {
      tarefas.add(TarefaSQLite(
          int.parse(el["id"].toString()),
          el["descricao"].toString(),
          el["concluido"]==1
        )
      );
    }
    return tarefas;
  }
  
  Future<void> insertTarefa(TarefaSQLite tarefaSQLite) async {
    var db = await SQLiteDatabase().getDatabase();
    int id = await db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?,?)',[
      tarefaSQLite.descricao, (tarefaSQLite.concluido ? 1 : 0)
    ]);
    debugPrint('insertTarefa: $id');
  }

  Future<void> updateTarefa(TarefaSQLite tarefaSQLite) async {
    var db = await SQLiteDatabase().getDatabase();
    int count = await db.rawUpdate('UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefaSQLite.descricao, (tarefaSQLite.concluido ? 1 : 0), tarefaSQLite.id
    ]);
    debugPrint('updateTarefa: $count');
  }

  Future<void> deleteTarefa(int id) async {
    var db = await SQLiteDatabase().getDatabase();
    int count = await db.rawDelete('DELETE FROM tarefas WHERE id = ?', [id]);
    debugPrint('deleteTarefa: $count');
  }
  
}