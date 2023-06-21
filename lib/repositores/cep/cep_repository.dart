import '../../model/via_cep_model.dart';

abstract class CepRepository {
  Future<ViaCepModel> getCep(String cep);
}