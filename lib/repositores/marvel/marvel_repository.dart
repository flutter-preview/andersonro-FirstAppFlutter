import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/shared/app_function.dart';

class MarvelRepository {

  Future<CharactersModel> getCharacters(int offset) async {
    var dio = Dio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = dotenv.env['MARVELPUBLICKEY'];
    var privateKey = dotenv.env['MARVELPRIVATEKEY'];
    var hash = AppFunction().generateMD5(ts + privateKey.toString() + publicKey.toString());

    var query = 'offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash';
    var result = await dio.get('https://gateway.marvel.com/v1/public/characters?$query');
    //var resultCode = result.statusCode;
    var charactersModel = CharactersModel.fromJson(result.data);

    return charactersModel;
  }




}