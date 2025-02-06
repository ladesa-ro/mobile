// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sisgha/app/data/model/nivel_formacao.dart';

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
      Uri.parse("https://dev.ladesa.com.br/api/v1/usuarios/$id/imagem/perfil");

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

  var url =
      Uri.parse("https://dev.ladesa.com.br/api/v1/usuarios/$id/imagem/capa");

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
    var url = Uri.parse("https://dev.ladesa.com.br/api/v1/autenticacao/login");
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
  var url =
      Uri.parse("https://dev.ladesa.com.br/api/v1/autenticacao/quem-sou-eu");

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
      Uri.parse("https://dev.ladesa.com.br/api/v1/autenticacao/login/refresh");
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

// ----------------------------------------------------------------------
Future<List<NiveisFormacao>> buscarNiveisDeFormacao() async {
  try {
    var url = Uri.parse("https://dev.ladesa.com.br/api/v1/niveis-formacoes");
    var resposta = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resposta.statusCode == 200) {
      final bodyDecode = jsonDecode(resposta.body)["data"];

      var listaFormacoes = <NiveisFormacao>[];

      for (var teste in bodyDecode) {
        print('até aqui $teste');
        NiveisFormacao niveisFormacao = NiveisFormacao.fromJson(teste);

        listaFormacoes.add(niveisFormacao);
      }

      return listaFormacoes;
    } else {
      throw Exception();
    }
  } catch (e) {
    throw Exception();
  }
}
