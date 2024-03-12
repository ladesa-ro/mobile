import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> _autenticarUsuario(String matricula, String senha, context) async {
  try {
    Dio dio = Dio();

    var data = {
      'usuario': matricula,
      'senha': senha,
    };

    var response = await dio.post(
        'https://luna.sisgha.com:1337/api/autenticacao/login',
        data: data);

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/navegacao', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Credenciais inválidas. Por favor, verifique seu nome de usuário e senha.'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Erro ao conectar-se ao servidor. Por favor, verifique sua conexão com a internet.'),
      ),
    );
  }
}
