// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/widgets/erro_connect.dart';
import 'package:sisgha/app/widgets/erro_connect_login.dart';

Future<bool> login(
    matriculaController, senhaController, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/login");
  var resposta = await http.post(url, body: {
    "matriculaSiape": matriculaController.text,
    "senha": senhaController.text,
  });
  if (resposta.statusCode == 201) {
    await sharedPreferences.setString(
        'token', "${jsonDecode(resposta.body)['access_token']}");
    await sharedPreferences.setString(
        'refreshToken', "${jsonDecode(resposta.body)['refresh_token']}");
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

Future<Map<String, dynamic>> buscarUser(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");
  var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/quem-sou-eu");
  var response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode >= 400 || 499 <= response.statusCode) {
    refreshToken(context);
  }
  if (response.statusCode == 200) {
    var jsondecode = json.decode(response.body)["usuario"];
    sharedPreferences.setString("id", jsondecode["id"]);
    return jsondecode;
  } else {
    throw Exception("Falha ao carregar");
  }
}

Future<bool> sair() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  return true;
}

Future<String?> pegarId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var id = sharedPreferences.getString("id");
  return id;
}

Future<void> refreshToken(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/login/refresh");
  var resposta = await http.post(url, body: {
    "refreshToken": sharedPreferences.getString("refreshToken"),
  });
  print(sharedPreferences.getString("refreshToken"));
  print(resposta.statusCode);
  if (resposta.statusCode == 201) {
    sharedPreferences.setString(
        "token", jsonDecode(resposta.body)["refresh_token"]);
  } else if (resposta.statusCode == 403) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErroConnectLogin();
      },
    );
  }
}
