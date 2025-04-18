// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../views/components/widget_erro.dart';
import '../model/professor.dart';
import '../model/cursos.dart';
import '../model/nivel_formacao.dart';
import '../model/token.dart';
import '../../data/providers/dados_professor.dart';

class Repository {
  static final String _api = "https://dev.ladesa.com.br/api/v1";

  // ---------------------------------------------------- HEADERS ------------------------------------------------------------------//
  static Map<String, String> _defaultHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.token}',
      };

  static bool verificarStatusCode(int statusCode) =>
      statusCode >= 200 && statusCode <= 299;

  static void _mostrarErro(BuildContext context, int statusCode) async {
    if (statusCode < 200) {
      return _erro(context, 'Erro no código');
    } else if (statusCode < 400) {
      return _erro(context, 'Erro no cliente');
    } else if (statusCode < 500) {
      return await _recarregarToken(context);
    } else {
      return _erro(context, 'Erro no servidor');
    }
  }

  static void _erro(BuildContext context, String texto) {
    showDialog(
      context: context,
      builder: (context) => dialogoDeErro(context, texto),
    );
  }

  static Future<void> _recarregarToken(BuildContext context) async {
    await refreshToken(context);
  }

  // -------------------------------------------------- LOGIN / TOKEN -------------------------------------------------------------//
  static Future<bool> login(TextEditingController matriculaController,
      TextEditingController senhaController) async {
    final url = Uri.parse("$_api/autenticacao/login");
    final resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    });

    if (verificarStatusCode(resposta.statusCode)) {
      final body = jsonDecode(resposta.body);
      Token.setToken(body['access_token']);
      Token.setRefreshToken(body['refresh_token']);
      return true;
    }

    return false;
  }

  static Future<bool> refreshToken(BuildContext context) async {
    final url = Uri.parse("$_api/autenticacao/login/refresh");
    final response = await http.post(url, body: {
      "refreshToken": Token.refreshToken,
    });

    if (verificarStatusCode(response.statusCode)) {
      final body = jsonDecode(response.body);
      Token.setToken(body["access_token"]);
      return true;
    }

    _mostrarErro(context, response.statusCode);
    return refreshToken(context);
  }

  // --------------------------------------------------- USUÁRIO ------------------------------------------------------------------//
  static Future<Professor> buscarUser(BuildContext context) async {
    final url = Uri.parse("$_api/autenticacao/quem-sou-eu");

    final response = await http.get(url, headers: _defaultHeaders());

    if (verificarStatusCode(response.statusCode)) {
      final data = json.decode(response.body)["usuario"];
      return Professor.fromJson(data);
    }

    _mostrarErro(context, response.statusCode);
    return buscarUser(context);
  }

  static Future<bool> sair(BuildContext context) async {
    final dados = DadosProfessor();
    dados.apagarDados();
    return true;
  }

  // --------------------------------------------------- IMAGENS ------------------------------------------------------------------//
  static Future<void> atualizarImagemPerfil(
      File imagemPerfil, BuildContext context) async {
    final id = DadosProfessor().professor.id;
    final url = Uri.parse("$_api/usuarios/$id/imagem/perfil");

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer ${Token.token}'
      ..files.add(await http.MultipartFile.fromPath('file', imagemPerfil.path));

    final response = await request.send();
    if (!verificarStatusCode(response.statusCode)) {
      _mostrarErro(context, response.statusCode);
    }
  }

  static Future<void> atualizarImagemCapa(
      File imagemCapa, BuildContext context) async {
    final id = DadosProfessor().professor.id;
    final url = Uri.parse("$_api/usuarios/$id/imagem/capa");

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer ${Token.token}'
      ..files.add(await http.MultipartFile.fromPath('file', imagemCapa.path));

    final response = await request.send();
    if (!verificarStatusCode(response.statusCode)) {
      _mostrarErro(context, response.statusCode);
    }
  }

  static Future<File> baixarImagemPerfil(String id) async {
    final url = Uri.parse("$_api/usuarios/$id/imagem/perfil");

    final response = await http.get(url);
    if (verificarStatusCode(response.statusCode)) {
      return _salvarImagemTemporaria(
          response.bodyBytes, 'downloaded_image_perfil.png');
    }

    throw Exception("Erro ao baixar imagem de perfil");
  }

  static Future<File> baixarImagemCapa(String id) async {
    final url = Uri.parse("$_api/usuarios/$id/imagem/capa");

    final response = await http.get(url);
    if (verificarStatusCode(response.statusCode)) {
      return _salvarImagemTemporaria(
          response.bodyBytes, 'downloaded_image_capa.png');
    }

    throw Exception("Erro ao baixar imagem de capa");
  }

  static Future<File> _salvarImagemTemporaria(
      List<int> bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  // ----------------------------------------------- LISTAGENS (Cursos / Nível) ---------------------------------------------------//
  static Future<List<NiveisFormacao>> buscarNiveisDeFormacao() async {
    final url = Uri.parse("$_api/niveis-formacoes");
    final response = await http.get(url, headers: _defaultHeaders());

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      return data
          .map<NiveisFormacao>((e) => NiveisFormacao.fromJson(e))
          .toList();
    }

    return buscarNiveisDeFormacao();
  }

  static Future<List<Cursos>> buscarCursos() async {
    final url = Uri.parse("$_api/cursos");
    final response = await http.get(url, headers: _defaultHeaders());

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      return data.map<Cursos>((e) => Cursos.fromJson(e)).toList();
    }

    return buscarCursos();
  }
}
