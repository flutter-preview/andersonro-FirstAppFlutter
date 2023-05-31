class ConfiguracoesModel {

  String _nomeUsuario = "";
  bool _receberNotificacoes = false;
  bool _temaEscuro = false;

  ConfiguracoesModel(this._nomeUsuario, this._receberNotificacoes, this._temaEscuro);

  ConfiguracoesModel.empty() {
    _nomeUsuario = "";
    _receberNotificacoes = false;
    _temaEscuro = false;
  }

  String get nomeUsuario => _nomeUsuario;
  set nomeUsuario(String nomeUsuario) {
    _nomeUsuario = nomeUsuario;
  }

  bool get recebeNotificacoes => _receberNotificacoes;
  set recebeNotificacoes(bool recebeNotificacoes) {
    _receberNotificacoes = recebeNotificacoes;
  }

  bool get temaEscuro => _temaEscuro;
  set temaEscuro(bool temaEscuro) {
    _temaEscuro = temaEscuro;
  }




}