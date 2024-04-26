import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> login(matriculaController, senhaController) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/login");
  var resposta = await http.post(url, body: {
    "matriculaSiape": matriculaController.text,
    "senha": senhaController.text,
  });
  if (resposta.statusCode == 201) {
    await sharedPreferences.setString(
        'token', "Token ${jsonDecode(resposta.body)['access_token']}");
    return true;
  } else {
    return false;
  }
}
