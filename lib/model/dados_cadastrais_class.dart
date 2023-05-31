import 'package:hive/hive.dart';

part 'dados_cadastrais_class.g.dart';

@HiveType(typeId: 0)
class DadosCadastraisModel extends HiveObject {

  @HiveField(0)
  String? _nome = "";

  @HiveField(1)
  DateTime? _dataNascimento = null;

  @HiveField(2)
  String? _nivelExperiencia = "";

  @HiveField(3)
  List<String> _liguangens = [];

  @HiveField(4)
  int _tempoExperiencia = 0;

  @HiveField(5)
  double _salario = 0;

  DadosCadastraisModel.empty() {
    _nome = "";
    _dataNascimento = null;
    _nivelExperiencia = "";
    _liguangens = [];
    _tempoExperiencia = 0;
    _salario = 0;
  }

  DadosCadastraisModel(
      this._nome,
      this._dataNascimento,
      this._nivelExperiencia,
      this._liguangens,
      this._tempoExperiencia,
      this._salario
      );

  String get nome => _nome ?? "";

  set nome(String value) {
    _nome = value;
  }

  double get salario => _salario;

  set salario(double value) {
    _salario = value;
  }

  int get tempoExperiencia => _tempoExperiencia;

  set tempoExperiencia(int value) {
    _tempoExperiencia = value;
  }

  List<String> get liguangens => _liguangens;

  set liguangens(List<String> value) {
    _liguangens = value;
  }

  String get nivelExperiencia => _nivelExperiencia ?? "";

  set nivelExperiencia(String value) {
    _nivelExperiencia = value;
  }

  DateTime get dataNascimento => _dataNascimento ?? DateTime.now();

  set dataNascimento(DateTime value) {
    _dataNascimento = value;
  }
}