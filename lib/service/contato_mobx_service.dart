import 'package:mobx/mobx.dart';

class ContadorMobxService {

  final _contador = Observable(0);
  int get contador => _contador.value;

  late Action incrementar;
  set value(int newValue) => _contador.value = newValue;

  void _incrementar() {
    _contador.value++;
  }

  ContadorMobxService() {
    incrementar = Action(_incrementar);
  }


}