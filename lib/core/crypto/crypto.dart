import 'dart:convert';
import 'package:crypto/crypto.dart';

class Crypto{
  static String encode(String pass){

    var bytes = utf8.encode(pass);
    return sha512.convert(bytes).toString();
  }
}