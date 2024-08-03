// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/widgets/erro_connect.dart';
import 'package:sisgha/app/widgets/erro_connect_login.dart';
import 'package:path/path.dart' as path;

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
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErroConnect();
      },
    );
  }
  return false;
}

Future<Map<String, File>> buscarImagens(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var id = sharedPreferences.getString("id");

  final capaUrl = "https://dev.ladesa.com.br/api/usuarios/$id/imagem/capa";
  final perfilUrl = "https://dev.ladesa.com.br/api/usuarios/$id/imagem/perfil";

  final directory = await getApplicationDocumentsDirectory();

  Future<File> downloadAndSaveImage(String url, String imageName) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final filePath = path.join(directory.path, imageName);
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Falha ao baixar a imagem $imageName');
    }
  }

  try {
    File capaFile = await downloadAndSaveImage(capaUrl, 'capa.jpg');
    File perfilFile = await downloadAndSaveImage(perfilUrl, 'perfil.jpg');
    return {'capa': capaFile, 'perfil': perfilFile};
  } catch (e) {
    print(e);
    throw Exception('Erro ao baixar as imagens');
  }
}

Future<UserModel> buscarUser(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = Uri.parse("https://dev.ladesa.com.br/api/autenticacao/quem-sou-eu");

  try {
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    if (response.statusCode == 403) {
      bool refreshed = await refreshToken(context);
      if (refreshed) {
        token = sharedPreferences.getString("token");
        response = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
      } else {
        throw Exception("Erro ao carregar");
      }
    }

    if (response.statusCode == 200) {
      var jsondecode = json.decode(response.body)["usuario"];
      UserModel user = UserModel.fromJson(jsondecode);
      print(user.nome);
      await sharedPreferences.setString("id", user.id);
      await sharedPreferences.setString("matricula", user.matricula);
      await sharedPreferences.setString("nome", user.nome);
      await sharedPreferences.setString("email", user.email);
      return user;
    } else {
      throw Exception("Falha ao carregar");
    }
  } catch (e) {
    print(e);
    throw Exception("Erro ao carregar usuário");
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
        return ErroConnectLogin();
      },
    );
    return false;
  }

  return false;
}
