import 'package:dio/dio.dart';
import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:trilhaapp/repositores/cep/cep_repository.dart';

class CepDioRepository implements CepRepository {

  @override
  Future<ViaCepModel> getCep(String cep) async {
    var _cep = cep.replaceAll(new RegExp(r'[^0-9]'), '');
    if (_cep.length == 8) {
      var urlCep = 'https://viacep.com.br/ws/$_cep/json/';
      var dio = Dio();
      var response = await dio.get(urlCep);
      if (response.statusCode==200) {
        //var json = jsonDecode(response.body);
        return ViaCepModel.fromJson(response.data);
      } else {
        return ViaCepModel();
      }
    }
    return ViaCepModel();
  }

}