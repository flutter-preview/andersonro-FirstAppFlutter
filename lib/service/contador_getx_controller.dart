import 'package:get/get.dart';

class ContadorGetXController extends GetxController {

  var contador = 0.obs;

  incrementar() => contador++;
}