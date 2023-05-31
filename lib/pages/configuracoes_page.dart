import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/shared/widgets/app_prefs.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  bool recebeNotificacoes = false;
  bool temaEscuro = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  void loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = prefs.getString(AppPrefs.APP_PREFS_NOME) ?? "";
      temaEscuro = prefs.getBool(AppPrefs.APP_PREFS_MODO_ESCURO) ?? false;
      recebeNotificacoes = prefs.getBool(AppPrefs.APP_PREFS_RECEBER_NOTIFICACOES) ?? false;
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
                value: recebeNotificacoes,
                onChanged: (bool value) {
                  setState(() {
                    recebeNotificacoes = value;
                  });
                }),
            SwitchListTile(
                title: const Text("Tema escuro"),
                value: temaEscuro,
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                }),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await prefs.setString(AppPrefs.APP_PREFS_NOME, nomeUsuarioController.text);
                  await prefs.setBool(AppPrefs.APP_PREFS_MODO_ESCURO, temaEscuro);
                  await prefs.setBool(AppPrefs.APP_PREFS_RECEBER_NOTIFICACOES, recebeNotificacoes);
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
