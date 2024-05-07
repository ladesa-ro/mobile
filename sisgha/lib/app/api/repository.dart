// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> login(
    matriculaController, senhaController, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/login");
  try {
    var resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    }).timeout(const Duration(seconds: 5));
    if (resposta.statusCode == 201) {
      await sharedPreferences.setString(
          'token', "Token ${jsonDecode(resposta.body)['access_token']}");
      return true;
    } else {
      return false;
    }
  } catch (e) {
    if (e is TimeoutException) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de Conexão'),
            content: Text(
                'O tempo limite da requisição foi atingido. Por favor, verifique sua conexão com a internet e tente novamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return false; // Adicionado para garantir que a função retorne um valor bool em todos os casos
  }
}
