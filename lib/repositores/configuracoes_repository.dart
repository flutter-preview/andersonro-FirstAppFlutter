import 'package:hive/hive.dart';
import 'package:trilhaapp/model/configuracoes_class.dart';

class ConfiguracoesRepository {
  static late Box _box;
  static final _BOX_NAME = "CONFIGURACOES";

  ConfiguracoesRepository._create();

  static Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
    } else {
      _box = await Hive.openBox(_BOX_NAME);
    }
    return ConfiguracoesRepository._create();
  }

  void save(ConfiguracoesModel configuracoesModel) {
    var save = _box.put(_BOX_NAME, {
      "nomeUsuario":configuracoesModel.nomeUsuario,
      "recebeNotificacoes":configuracoesModel.recebeNotificacoes,
      "temaEscuro":configuracoesModel.temaEscuro
    });
  }

  ConfiguracoesModel loadConfiguracoesModel() {
    var config = _box.get(_BOX_NAME);
    if (config == null) {
      return ConfiguracoesModel.empty();
    } else {
      return ConfiguracoesModel(
          config["nomeUsuario"],
          config["recebeNotificacoes"],
          config["temaEscuro"]
      );
    }
  }
}