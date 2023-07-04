import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_class.dart';
import 'package:trilhaapp/model/tarefa_hive_class.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'service/contador_getx_controller.dart';

final getIt = GetIt.instance;

setGetIt() {
  getIt.registerSingleton<ContadorGetXController>(ContadorGetXController());
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();

  setGetIt();

  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}





