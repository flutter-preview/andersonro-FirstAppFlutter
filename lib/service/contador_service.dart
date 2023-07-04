import 'package:flutter/foundation.dart';

class ContadorService extends ChangeNotifier {

  int _contador = 0;

  int get contador => _contador;

  void increment() {
    _contador++;
    notifyListeners();
  }

}