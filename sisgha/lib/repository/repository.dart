// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/domain/model/dados_ensino.dart';
import 'package:sisgha/domain/model/disciplinas.dart';
import 'package:sisgha/domain/model/etapas.dart';
import 'package:sisgha/domain/model/eventos.dart';
import 'package:sisgha/domain/model/teste_disciplinas.dart';
import 'package:sisgha/domain/model/teste_turmas.dart';
import 'package:sisgha/domain/model/turmas.dart';

import '../widgets/widget_erro.dart';
import '../domain/model/professor.dart';
import '../domain/model/cursos.dart';
import '../domain/model/nivel_formacao.dart';
import '../viewmodels/dados_professor.dart';

class Repository {
  static final String _api = "https://dev.ladesa.com.br/api/v1";

  // ---------------------------------------------------- VERIFICADORES ------------------------------------------------------------------//

  static bool verificarStatusCode(int statusCode) =>
      statusCode >= 200 && statusCode <= 299;

  static void _mostrarErro(BuildContext context, int statusCode) async {
    if (statusCode < 200) {
      return _erro(context);
    } else if (statusCode < 400) {
      return _erro(
        context,
      );
    } else if (statusCode < 500) {
      return await _recarregarToken(context);
    } else {
      return _erro(
        context,
      );
    }
  }

  static void _erro(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => dialogoDeErro(context, tema),
    );
  }

  static Future<void> _recarregarToken(BuildContext context) async {
    await refreshToken(context);
  }

  // -------------------------------------------------- LOGIN / TOKEN -------------------------------------------------------------//

  static Future<bool> login(TextEditingController matriculaController,
      TextEditingController senhaController) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();

    final url =
        Uri.parse("https://dev.ladesa.com.br/api/v1/autenticacao/login");
    final resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    });

    if (verificarStatusCode(resposta.statusCode)) {
      final body = jsonDecode(resposta.body);

      armazenamento.setString('token', body['access_token']);
      armazenamento.setString('refreshToken', body['refresh_token']);

      return true;
    }

    return false;
  }

  static Future<bool> refreshToken(BuildContext context) async {
    final armazenamento = await SharedPreferences.getInstance();
    final url = Uri.parse("$_api/autenticacao/login/refresh");
    final response = await http.post(url, body: {
      "refreshToken": armazenamento.getString('refreshToken'),
    });

    if (verificarStatusCode(response.statusCode)) {
      final body = jsonDecode(response.body);
      armazenamento.setString('token', body["access_token"]);
      return true;
    }

    _mostrarErro(context, response.statusCode);
    return refreshToken(context);
  }

  // --------------------------------------------------- USUÁRIO ------------------------------------------------------------------//
  static Future<Professor> buscarUser(BuildContext context) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    final url = Uri.parse("$_api/autenticacao/quem-sou-eu");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${armazenamento.getString('token')}'
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = json.decode(response.body)["usuario"];

      final user = Professor.fromJson(data);

      armazenamento.setString('id', user.id);
      armazenamento.setString('email', user.email);
      armazenamento.setString('matricula', user.matricula);
      armazenamento.setString('nome', user.nome);

      return user;
    }

    _mostrarErro(context, response.statusCode);
    return buscarUser(context);
  }

  static Future<bool> sair(BuildContext context) async {
    final armazenamento = await SharedPreferences.getInstance();
    await armazenamento.clear();
    final dados = DadosProfessor();
    dados.apagarDados();
    return true;
  }

  // --------------------------------------------------- IMAGENS ------------------------------------------------------------------//
  static Future<void> atualizarImagemPerfil(
      File imagemPerfil, BuildContext context) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    final id = DadosProfessor().professor.id;
    final url = Uri.parse("$_api/usuarios/$id/imagem/perfil");

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer ${armazenamento.getString('token')}'
      ..files.add(await http.MultipartFile.fromPath('file', imagemPerfil.path));

    final response = await request.send();
    if (!verificarStatusCode(response.statusCode)) {
      _mostrarErro(context, response.statusCode);
    }
  }

  static Future<void> atualizarImagemCapa(
      File imagemCapa, BuildContext context) async {
    SharedPreferences armazenamento = await SharedPreferences.getInstance();
    final id = DadosProfessor().professor.id;
    final url = Uri.parse("$_api/usuarios/$id/imagem/capa");

    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer ${armazenamento.getString('token')}'
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
  static Future<List<OfertaFormacao>> buscarNiveisDeFormacao() async {
    final url = Uri.parse("$_api/ofertas-formacoes");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      return data
          .map<OfertaFormacao>((e) => OfertaFormacao.fromJson(e))
          .toList();
    }

    return <OfertaFormacao>[];
  }

  //VERIFICAR braga do futuro
  static Future<List<Cursos>> buscarCursos(
      {required String ofertaFormacaoId}) async {
    final url = Uri.https(
      'dev.ladesa.com.br', // domínio base
      '/api/v1/cursos', // caminho da API
      {
        'filter.ofertaFormacao.id': ofertaFormacaoId, // query parameter
      },
    );

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      return data.map<Cursos>((e) => Cursos.fromJson(e)).toList();
    }

    return <Cursos>[];
  }

  static Future<List<Turma>> buscarTurmas({required String nomeCurso}) async {
    final url = Uri.https(
      'dev.ladesa.com.br',
      '/api/v1/turmas',
      {
        'filter.curso.nome': nomeCurso,
      },
    );

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      return data.map<Turma>((e) => Turma.fromJson(e)).toList();
    }

    return <Turma>[];
  }

  // -----------------------------------------------------------------calendario
  static Future<List<Etapas>> buscarEtapas() async {
    final url = Uri.parse('$_api/etapas');
    final resposta = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (verificarStatusCode(resposta.statusCode)) {
      final data = jsonDecode(resposta.body)['data'];
      return data.map<Etapas>((e) => Etapas.fromJson(e)).toList();
    }
    return <Etapas>[];
  }

  static Future<List<Eventos>> buscarEventos() async {
    final url = Uri.parse('$_api/eventos');
    final resposta = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (verificarStatusCode(resposta.statusCode)) {
      final data = jsonDecode(resposta.body)['data'];
      return data.map<Eventos>((e) => Eventos.fromJson(e)).toList();
    }
    return <Eventos>[];
  }

// ---------------------------------------- testar rotas, clicar no botao de recuperar senha

// id do usuario 0 = 17ed5d7e-79d4-4cfd-811c-263247dc4511
  static void teste() async {
    // final url =
    //     Uri.parse("$_api/usuarios/17ed5d7e-79d4-4cfd-811c-263247dc4511/ensino");
    // final response = await http.get(url, headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    // });

    // print(response.statusCode);
    // if (verificarStatusCode(response.statusCode)) {
    //   final data = jsonDecode(response.body)['disciplinas'];
    //   print(data[1]['cursos'][0]['turmas'][0]['turma']['periodo']);
    //   print('---------------------------');

    // for (var element in data) {
    //   print(element["periodo"]);
    //   print(element["id"]);
    // }
    //  }
  }

  // -------------------------------------- retirar esses 'testar' e trocar por algo mais usual -----------------------------------
  static Future<void> testeBuscarTurmas() async {
    final url = Uri.parse("$_api/turmas");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      TesteTurma()
          .PegarTurmas(data.map<Turma>((e) => Turma.fromJson(e)).toList());
    }
  }

  static Future<void> testeBuscarDisciplinas() async {
    final url = Uri.parse("$_api/disciplinas");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)["data"];
      TesteDisciplinas().PegarDisciplinas(
          data.map<Disciplina>((e) => Disciplina.fromJson(e)).toList());
    }
  }

  // -----------------------
  static Future<List<DadosEnsino>> buscarEnsinoProfessor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url =
        Uri.parse("$_api/usuarios/${sharedPreferences.getString('id')}/ensino");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (verificarStatusCode(response.statusCode)) {
      final data = jsonDecode(response.body)['disciplinas'];
      List<DadosEnsino> dados = [];

      for (var item in data) {
        final disciplina = Disciplina.fromJson(item['disciplina']);

        List<CursoComTurmas> cursos = [];
        final cursosJson = item['cursos'] as List;

        for (var cursoItem in cursosJson) {
          final curso = Cursos.fromJson(cursoItem['curso']);

          final turmasJson = cursoItem['turmas'] as List;
          final turmas = turmasJson
              .map((turmaItem) => Turma.fromJson(turmaItem['turma']))
              .toList();

          cursos.add(CursoComTurmas(curso: curso, turmas: turmas));
        }

        dados.add(DadosEnsino(disciplina: disciplina, cursos: cursos));
      }
      return dados;
    }
    throw Exception();
  }
}
