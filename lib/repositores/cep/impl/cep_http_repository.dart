import 'dart:convert';

import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/repositores/cep/cep_repository.dart';

class CepHttpRepository implements CepRepository {

  @override
  Future<ViaCepModel> getCep(String cep) async {
    var _cep = cep.replaceAll(new RegExp(r'[^0-9]'), '');
    if (_cep.length == 8) {
      var urlCep = 'https://viacep.com.br/ws/$_cep/json/';
      var response = await http.get(Uri.parse(urlCep));
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        return ViaCepModel.fromJson(json);
      } else {
        return ViaCepModel();
      }
    }
    return ViaCepModel();
  }

}