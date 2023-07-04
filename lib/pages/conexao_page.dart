import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConexaoPage extends StatefulWidget {
  const ConexaoPage({super.key});

  @override
  State<ConexaoPage> createState() => _ConexaoPageState();
}

class _ConexaoPageState extends State<ConexaoPage> {

  late StreamSubscription subscription;
  var conexao = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  loadConexao() async {

    final connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult: ${connectivityResult}");

    if (connectivityResult == ConnectivityResult.mobile) {
      conexao = "Mobile";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      conexao = "Wifi";
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      conexao = "Ethernet";
    } else if (connectivityResult == ConnectivityResult.vpn) {
      conexao = "VPN";
      // I am connected to a vpn network.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      conexao = "Bluetooth";
    } else if (connectivityResult == ConnectivityResult.other) {
      // I am connected to a network which is not in the above mentioned networks.
      conexao = "other";
    } else if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to any network.
      conexao = "none";
    }

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Conexão"),),
          body: Column(
            children: [
              Container(
                child: Text("Minha conexão: ${conexao}"),
              ),
              TextButton(
                  onPressed: () async {
                    loadConexao();
                  },
                  child: const Text("Minha Conexao")
              ),
            ],
          ),
        )
    );
  }
}
