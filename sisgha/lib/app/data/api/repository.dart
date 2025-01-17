// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/data/model/professor.dart';
import 'package:sisgha/app/views/widgets_globais/widget_erro.dart';

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

    var responseData = await http.Response.fromStream(response);
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${responseData.body}");

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
        return dialogoDeErro(context);
      },
    );
  }

  return false;
}

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
    // var responseData = await http.Response.fromStream(response);
    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${responseData.body}");

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
        return dialogoDeErro(context);
      },
    );
  }

  return false;
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------
Future<bool> login(TextEditingController matriculaController,
    TextEditingController senhaController, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
        return dialogoDeErro(context);
      },
    );
  }
  return false;
}

Future<Professor> buscarUser(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = Uri.parse("https://dev.ladesa.com.br/api/autenticacao/quem-sou-eu");

  try {
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

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
        throw dialogoDeErro(context);
      }
    }

    if (response.statusCode == 200) {
      var jsondecode = json.decode(response.body)["usuario"];

      Professor user = Professor.fromJson(jsondecode);

      await sharedPreferences.setString("id", user.id);
      await sharedPreferences.setString("matricula", user.matricula);
      await sharedPreferences.setString("nome", user.nome);
      await sharedPreferences.setString("email", user.email);
      return user;
    } else {
      throw dialogoDeErro(context);
    }
  } catch (e) {
    throw dialogoDeErro(context);
  }
}

Future<bool> sair() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  return true;
}

Future<String?> pegarId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("id");
}

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
        return dialogoDeErro(context);
      },
    );
    return false;
  }

  return false;
}

Future<void> teste() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var id = sharedPreferences.getString("id");

  if (id == null || token == null) {
    return print('um dos dois é nulo');
  }

  var url = Uri.parse("https://dev.ladesa.com.br/api/disciplinas/$id");

  try {
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return print(response.statusCode);
  } catch (e) {
    return print(e);
  }

  return Future(() => print(
      'até aqui tudo bem -------------------------------------------------------------------------------------------- \n $token'));
}
