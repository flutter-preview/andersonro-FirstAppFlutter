import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/main_page.dart';

import '../shared/widgets/app_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override

  bool logado = false;

  void loadPrefs() {
    Future.delayed(const Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? prefsLogado = prefs.getString(AppPrefs.APP_PREFS_EMAIL);
      print("prefsLogado: ${prefsLogado}");
      if (prefsLogado != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
      }else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.network("https://hermes.digitalinnovation.one/assets/diome/logo.png", height: 90,)),
        ],
      ),
    );
  }
}
