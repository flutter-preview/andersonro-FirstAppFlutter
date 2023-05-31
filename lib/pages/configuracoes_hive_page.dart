import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/model/configuracoes_class.dart';
import 'package:trilhaapp/repositores/configuracoes_repository.dart';
import 'package:trilhaapp/shared/widgets/app_prefs.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {

  TextEditingController nomeUsuarioController = TextEditingController();
  bool recebeNotificacoes = false;
  bool temaEscuro = false;

  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.empty();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoesModel = configuracoesRepository.loadConfiguracoesModel();

    setState(() {
      nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: Container(
        child: ListView(
          children: [

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nomeUsuarioController,
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,                
                decoration: const InputDecoration(
                  label: const Text("Nome usuário"),
                  hintText: "Nome completo",
                ),
              ),
            ),
            SwitchListTile(
                title: const Text("Receber notificações"),
                value: configuracoesModel.recebeNotificacoes,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.recebeNotificacoes = value;
                  });
                }),
            SwitchListTile(
                title: const Text("Tema escuro"),
                value: configuracoesModel.temaEscuro,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.temaEscuro = value;
                  });
                }),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracoesRepository.save(configuracoesModel);

                  Navigator.pop(context);
                },
                child: const Text("Salvar")
            )
          ],
        ),
      ),
    ));
  }
}
