import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_class.dart';

class DadosCadastraisRepository {

  static late Box _box;
  static const String _BOX_NAME = "DADOS_CADASTRAIS";

  DadosCadastraisRepository._create();

  static Future<DadosCadastraisRepository> load() async {
    if (Hive.isBoxOpen(_BOX_NAME)) {
      _box = Hive.box(_BOX_NAME);
    } else {
      _box = await Hive.openBox(_BOX_NAME);
    }
    return DadosCadastraisRepository._create();
  }

  save(DadosCadastraisModel dadosCadastraisModel) {
    var save = _box.put(_BOX_NAME, dadosCadastraisModel);
  }

  DadosCadastraisModel loadData() {
    var dadosCadastraisModel = _box.get(_BOX_NAME);
    if (dadosCadastraisModel == null) {
      return DadosCadastraisModel.empty();
    }
    return dadosCadastraisModel;
  }

}