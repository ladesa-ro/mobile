// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/data/model/cursos.dart';
import 'package:sisgha/app/data/model/nivel_formacao.dart';

import '../../views/widgets_globais/widget_erro.dart';
import '../model/professor.dart';
import '../providers/dados_professor.dart';

class Repository {
  static final String api = "https://dev.ladesa.com.br/api/v1";

  static void erro(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogoDeErro(context, 'erro no codigo');
      },
    );
  }

  static bool verificarStatusCode(int statusCode) {
    if (statusCode >= 200 && statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static void recarregarToken(BuildContext context, Function metodo) async {
    return await refreshToken(context).then((_) => metodo);
  }

  static void escolherCaminho(
      BuildContext context, int statusCode, Function metodo) {
    if (statusCode <= 199) {
      erro(context, 'erro no codigo');
    }
    if (statusCode >= 300 && statusCode <= 399) {
      erro(context, 'erro no cliente');
    }
    if (statusCode >= 400 && statusCode <= 499) {
      recarregarToken(context, metodo);
    }
    if (statusCode >= 500) {
      erro(context, 'erro no servidor');
    } else {
      erro(context, 'algo de errado nao esta certo');
    }
  }

  // ----------------------------------------------------------  ATUALIZAR FOTO DE PERFIL DO USUARIO -----------------------------------------------------------------------//
  static Future<void> atualizarImagemPerfil(
      File imagemPerfil, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? id = sharedPreferences.getString("id");

    if (token == null || id == null) {
      print("Token ou ID não encontrado.");
      erro(context, 'token ou id nulos');
    }

    var url = Uri.parse("$api/usuarios/$id/imagem/perfil");

    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemPerfil.path,
      ));

    var response = await request.send();

    if (verificarStatusCode(response.statusCode) == false) {
      escolherCaminho(context, response.statusCode,
          () => atualizarImagemPerfil(imagemPerfil, context));
    }
    return;
  }

  // ------------------------------------------------------------------- ATUALIZAR A IMAGEM DE FUNDO DO USUARIO -------------------------------------------------------------//
  static Future<void> atualizarImagemCapa(
      File imagemCapa, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? id = sharedPreferences.getString("id");

    if (token == null || id == null) {
      print("Token ou ID não encontrado.");
      erro(context, 'token ou id nulos');
    }

    var url = Uri.parse("$api/usuarios/$id/imagem/capa");

    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemCapa.path,
      ));

    var response = await request.send();

    if (verificarStatusCode(response.statusCode) == false) {
      escolherCaminho(context, response.statusCode,
          () => atualizarImagemCapa(imagemCapa, context));
    }
    return;
  }

  //-------------------------------------------------------------------- BUSCAR O TOKEN DO USUARIO ------------------------------------------------------------------------------------------//
  static Future<bool> login(TextEditingController matriculaController,
      TextEditingController senhaController, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse("$api/autenticacao/login");
    var resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    });

    if (verificarStatusCode(resposta.statusCode)) {
      final body = jsonDecode(resposta.body);
      await sharedPreferences.setString('token', body['access_token']);
      await sharedPreferences.setString('refreshToken', body['refresh_token']);
      return true;
    } else if (resposta.statusCode == 403) {
      return false;
    } else {
      erro(context, 'bucar token de usuario 1');
    }
    return false;
  }

  // -------------------------------------------------------------------------- FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO -------------------------------------------------------------------------------------//
  static Future<dynamic> buscarUser(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = Uri.parse("$api/autenticacao/quem-sou-eu");

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (verificarStatusCode(response.statusCode)) {
      var jsondecode = json.decode(response.body)["usuario"];

      Professor user = Professor.fromJson(jsondecode);

      await sharedPreferences.setString("id", user.id);
      await sharedPreferences.setString("matricula", user.matricula);
      await sharedPreferences.setString("nome", user.nome);
      await sharedPreferences.setString("email", user.email);
      return user;
    } else {
      escolherCaminho(context, response.statusCode, () => buscarUser(context));
    }
  }

  // ---------------------------------------------------------- RECARREGAR TOKEM DE ACESSO DO USUARIO CASO TENHA EXPIRADO ---------------------------------------------------------------------//
  static Future<bool> refreshToken(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var refreshToken = sharedPreferences.getString("refreshToken");

    if (refreshToken == null) {
      return false;
    }

    var url = Uri.parse("$api/autenticacao/login/refresh");
    var response = await http.post(url, body: {
      "refreshToken": refreshToken,
    });

    if (verificarStatusCode(response.statusCode)) {
      final body = jsonDecode(response.body);
      await sharedPreferences.setString("token", body["access_token"]);
      return true;
    } else if (response.statusCode == 403) {
      erro(context, 'recarregar token');
      return false;
    }

    return false;
  }

  // ---------------------------------------------------- APAGAR DADOS SALVOS ----------------------------------------------------------------------------------//
  static Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    DadosProfessor dados = DadosProfessor();
    dados.apagarDados();
    return true;
  }

  // ----------------------------------------------------------------------
  static Future<List<NiveisFormacao>> buscarNiveisDeFormacao(context) async {
    var url = Uri.parse("$api/niveis-formacoes");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (verificarStatusCode(response.statusCode)) {
      final bodyDecode = jsonDecode(response.body)["data"];

      var listaFormacoes = <NiveisFormacao>[];

      for (var item in bodyDecode) {
        print('até aqui $item');
        NiveisFormacao niveisFormacao = NiveisFormacao.fromJson(item);

        listaFormacoes.add(niveisFormacao);
      }

      return listaFormacoes;
    } else {
      escolherCaminho(
          context, response.statusCode, () => buscarNiveisDeFormacao(context));
    }
    throw Exception();
  }

  static Future<List<Cursos>> buscarCursos(BuildContext context) async {
    var url = Uri.parse("$api/cursos");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (verificarStatusCode(response.statusCode)) {
      final bodyDecode = jsonDecode(response.body)["data"];

      var listaCursos = <Cursos>[];

      for (var item in bodyDecode) {
        Cursos cursos = Cursos.fromJson(item);

        listaCursos.add(cursos);
      }

      return listaCursos;
    } else {
      escolherCaminho(
          context, response.statusCode, () => buscarCursos(context));
    }
    return buscarCursos(context);
  }
}
