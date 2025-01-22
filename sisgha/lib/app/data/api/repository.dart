// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../views/widgets_globais/widget_erro.dart';
import '../model/professor.dart';
import '../providers/dados_professor.dart';

// ----------------------------------------------------------  ATUALIZAR FOTO DE PERFIL DO USUARIO -----------------------------------------------------------------------//
Future<bool> atualizarImagemPerfil(
    File imagemPerfil, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  String? id = sharedPreferences.getString("id");

  if (token == null || id == null) {
    print("Token ou ID não encontrado.");
    return false;
  }

  var url =
      Uri.parse("https://dev.ladesa.com.br/api/usuarios/$id/imagem/perfil");

  try {
    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemPerfil.path,
      ));

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      bool refreshed = await refreshToken(context);
      if (refreshed) {
        token = sharedPreferences.getString("token");
        request.headers['Authorization'] = 'Bearer $token';
        response = await request.send();
        var responseData = await http.Response.fromStream(response);
        print("Status Code após refresh: ${response.statusCode}");
        print("Response Body após refresh: ${responseData.body}");
        return response.statusCode == 200;
      }
    }
  } catch (e) {
    print("Erro ao atualizar imagem: $e");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(context, 'ATUALIZAR FOTO DE PERFIL DO USUARIO');
      },
    );
  }

  return false;
}

// ------------------------------------------------------------------- ATUALIZAR A IMAGEM DE FUNDO DO USUARIO -------------------------------------------------------------//
Future<bool> atualizarImagemCapa(File imagemCapa, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  String? id = sharedPreferences.getString("id");

  if (token == null || id == null) {
    print("Token ou ID não encontrado.");
    return false;
  }

  var url = Uri.parse("https://dev.ladesa.com.br/api/usuarios/$id/imagem/capa");

  try {
    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemCapa.path,
      ));

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      bool refreshed = await refreshToken(context);
      if (refreshed) {
        token = sharedPreferences.getString("token");
        request.headers['Authorization'] = 'Bearer $token';
        response = await request.send();

        return response.statusCode == 200;
      }
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(context, 'ATUALIZAR A IMAGEM DE FUNDO DO USUARIO');
      },
    );
  }

  return false;
}

//-------------------------------------------------------------------- BUSCAR O TOKEN DO USUARIO ------------------------------------------------------------------------------------------//
Future<bool> login(TextEditingController matriculaController,
    TextEditingController senhaController, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  try {
    var url = Uri.parse("https://dev.ladesa.com.br/api/autenticacao/login");
    var resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    });

    if (resposta.statusCode == 201) {
      final body = jsonDecode(resposta.body);
      await sharedPreferences.setString('token', body['access_token']);
      await sharedPreferences.setString('refreshToken', body['refresh_token']);
      return true;
    } else if (resposta.statusCode == 403) {
      return false;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(context, 'BUSCAR O TOKEN DO USUARIO1');
        },
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(context, 'BUSCAR O TOKEN DO USUARIO 2');
      },
    );
  }
  return false;
}

// -------------------------------------------------------------------------- FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO -------------------------------------------------------------------------------------//
Future<dynamic> buscarUser(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = Uri.parse("https://dev.ladesa.com.br/api/autenticacao/quem-sou-eu");

  try {
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsondecode = json.decode(response.body)["usuario"];

      Professor user = Professor.fromJson(jsondecode);

      await sharedPreferences.setString("id", user.id);
      await sharedPreferences.setString("matricula", user.matricula);
      await sharedPreferences.setString("nome", user.nome);
      await sharedPreferences.setString("email", user.email);
      return user;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogoDeErro(
              context, 'FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO 1');
        },
      );
    }
    if (response.statusCode == 401) {
      bool refreshed = await refreshToken(context);
      if (refreshed) {
        token = sharedPreferences.getString("token");
        response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialogoDeErro(
                context, 'FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO 2');
          },
        );
      }
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(
            context, 'FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO 3');
      },
    );
  }
}

// ---------------------------------------------------------- RECARREGAR TOKEM DE ACESSO DO USUARIO CASO TENHA EXPIRADO ---------------------------------------------------------------------//
Future<bool> refreshToken(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var refreshToken = sharedPreferences.getString("refreshToken");

  if (refreshToken == null) {
    return false;
  }

  var url =
      Uri.parse("https://dev.ladesa.com.br/api/autenticacao/login/refresh");
  var resposta = await http.post(url, body: {
    "refreshToken": refreshToken,
  });

  if (resposta.statusCode == 201) {
    final body = jsonDecode(resposta.body);
    await sharedPreferences.setString("token", body["access_token"]);
    return true;
  } else if (resposta.statusCode == 403) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(context, 'recarregar token');
      },
    );
    return false;
  }

  return false;
}

// ---------------------------------------------------- APAGAR DADOS SALVOS ----------------------------------------------------------------------------------//
Future<bool> sair() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  DadosProfessor dados = DadosProfessor();
  dados.apagarDados();
  return true;
}

Future<bool> teste() async {
//  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//  final token = sharedPreferences.getString("token");
  var url = Uri.parse("https://dev.ladesa.com.br/api/usuarios");
  var resposta = await http.get(url);

  print(
      '-----------------------------------------------------------------------');
  print(resposta.body[34]);
  return Future(() => true);
}
/*[123, 34, 100, 97, 116, 97, 34, 58, 91, 123, 34, 105, 100, 34, 58, 34, 49, 55, 101, 100, 53, 100, 55,
 101, 45, 55, 57, 100, 52, 45, 52, 99, 102, 100, 45, 56, 49, 49, 99, 45, 50, 54, 51, 50, 52, 55, 100,
  99, 52, 53, 49, 49, 34, 44, 34, 110, 111, 109, 101, 34, 58, 34, 65, 100, 109, 105, 110, 105, 115, 116,
   114, 97, 100, 111, 114, 34, 44, 34, 109, 97, 116, 114, 105, 99, 117, 108, 97, 83, 105, 97, 112, 101,
    34, 58, 34, 48, 34, 44, 34, 101, 109, 97, 105, 108, 34, 58, 34, 97, 100, 109, 105, 110, 64, 115, 105,
     115, 103, 104, 97, 46, 99, 111, 109, 46, 98, 114, 34, 44, 34, 105, 115, 83, 117, 112, 101, 114, 85,
      115, 101, 114, 34, 58, 116, 114, 117, 101, 44, 34, 100, 97, 116, 101, 67, 114, 101, 97, 116, 101,
       100, 34, 58, 34, 50, 48, 50, 52, 45, 49, 48, 45, 50, 57, 84, 49, 57, 58, 50, 49, 58, 51, 51, 46,
        51, 52, 48, 90, 34, 44, 34, 100, 97, 116, 101, 85, 112, 100, 97, 116, 101, 100, 34, 58, 34, 50,
         48, 50, 53, 45, 48, 49, 45, 50, 50, 84, 50, 48, 58, 48, 53, 58, 53, 57, 46, 55, 53, 48, 90, 34,
          44, 34, 100, 97, 116, 101,*/