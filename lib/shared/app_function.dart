import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class AppFunction {

  String generateMD5(String str) {
    var content = const Utf8Encoder().convert(str);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return digest.toString();
  }

}