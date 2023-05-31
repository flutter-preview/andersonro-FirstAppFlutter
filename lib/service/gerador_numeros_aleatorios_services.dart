import 'dart:math';

class GeradorNumeroAleatorioService {
  static int gerarNumeroAleatorio(int numero_max) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numero_max);
  }
}