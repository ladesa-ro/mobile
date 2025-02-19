// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/domain/model/cursos.dart';
import 'package:sisgha/app/domain/model/nivel_formacao.dart';

import '../../views/widgets_globais/widget_erro.dart';
import '../model/professor.dart';
import '../../data/providers/dados_professor.dart';

class Repository {
  static final String _api = "https://dev.ladesa.com.br/api/v1";

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

  static void recarregarToken(
    BuildContext context,
  ) async {
    await refreshToken(context);
  }

  static void mostrarErro(BuildContext context, int statusCode) {
    if (statusCode <= 199) {
      return erro(context, 'erro no codigo');
    }
    if (statusCode >= 300 && statusCode <= 399) {
      return erro(context, 'erro no cliente');
    }
    if (statusCode >= 400 && statusCode <= 499) {
      return recarregarToken(context);
    }
    if (statusCode >= 500) {
      return erro(context, 'erro no servidor');
    } else {
      return erro(context, 'algo de errado nao esta certo');
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

    var url = Uri.parse("$_api/usuarios/$id/imagem/perfil");

    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemPerfil.path,
      ));

    var response = await request.send();

    if (verificarStatusCode(response.statusCode) == false) {
      mostrarErro(context, response.statusCode);
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

    var url = Uri.parse("$_api/usuarios/$id/imagem/capa");

    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imagemCapa.path,
      ));

    var response = await request.send();

    if (verificarStatusCode(response.statusCode) == false) {
      mostrarErro(context, response.statusCode);
    }
    return;
  }

  //-------------------------------------------------------------------- BUSCAR O TOKEN DO USUARIO ------------------------------------------------------------------------------------------//
  static Future<bool> login(TextEditingController matriculaController,
      TextEditingController senhaController, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse("$_api/autenticacao/login");
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
      false;
    } else {
      mostrarErro(context, resposta.statusCode);
      return false;
    }
    return false;
  }

  // -------------------------------------------------------------------------- FAZER REQUISIÇÃO NA API PRA BUSCAR O USUARIO -------------------------------------------------------------------------------------//
  static Future<Professor> buscarUser(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var url = Uri.parse("$_api/autenticacao/quem-sou-eu");

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
      mostrarErro(context, response.statusCode);
      return buscarUser(context);
    }
  }

  // ---------------------------------------------------------- RECARREGAR TOKEM DE ACESSO DO USUARIO CASO TENHA EXPIRADO ---------------------------------------------------------------------//
  static Future<bool> refreshToken(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var recarregarToken = sharedPreferences.getString("refreshToken");

    if (recarregarToken == null) {
      erro(context, 'token nulo');
    }

    var url = Uri.parse("$_api/autenticacao/login/refresh");
    var response = await http.post(url, body: {
      "refreshToken": recarregarToken,
    });

    if (verificarStatusCode(response.statusCode)) {
      final body = jsonDecode(response.body);
      await sharedPreferences.setString("token", body["access_token"]);
      return true;
    } else {
      mostrarErro(context, response.statusCode);
      return refreshToken(context);
    }
  }

  // ---------------------------------------------------- APAGAR DADOS SALVOS ----------------------------------------------------------------------------------//
  static Future<bool> sair(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    DadosProfessor dados = DadosProfessor();
    dados.apagarDados(context);
    return true;
  }

  // ----------------------------------------------------------------------
  static Future<List<NiveisFormacao>> buscarNiveisDeFormacao(context) async {
    var url = Uri.parse("$_api/niveis-formacoes");
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
      mostrarErro(context, response.statusCode);
      return buscarNiveisDeFormacao(context);
    }
  }

  static Future<List<Cursos>> buscarCursos(BuildContext context) async {
    var url = Uri.parse("$_api/cursos");
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
      mostrarErro(context, response.statusCode);
      return buscarCursos(context);
    }
  }
}
