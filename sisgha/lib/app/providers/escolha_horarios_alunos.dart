// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/model/Turmas.dart';
import 'package:sisgha/app/domain/model/cursos.dart';
import 'package:sisgha/app/domain/model/nivel_formacao.dart';
import 'package:http/http.dart' as http;

class EscolhaHorariosAlunos extends ChangeNotifier {
  String? formacaoSelecionada;
  String? cursoSelecionado;
  String? anoSelecionado;
  String? turmaSelecionada;

  List<OfertaFormacao> listaNivelFormacao = [];
  List<Cursos> listaCursos = [];
  List<String> listaAnos = ["1° Ano B", "2° Ano B", "3° Ano B"];
  List<Turma> listaTurmas = [];

  String? _cursoSelecionado;

  static final String _api = "https://dev.ladesa.com.br/api/v1";
  String? get cursoSelecionad => _cursoSelecionado;
  List<String> get listaAno => listaAnos;

  void carregarAnosDoCurso(String curso) async {
    _cursoSelecionado = curso;

    final response = await http.get(Uri.parse("$_api/turmas"));
    final decoded = json.decode(response.body);

    if (decoded is Map && decoded.containsKey('data')) {
      final List<dynamic> dataList = decoded['data'];
      listaAnos = dataList
          .map<String>(
              (e) => e['periodo']?.toString() ?? '') // pega o campo 'periodo'
          .where((element) => element.isNotEmpty) // filtra só não vazios
          .toSet() // evita repetições
          .toList();
    } else {
      listaAnos = [];
      print("Formato do JSON inesperado");
    }

    notifyListeners();
  }

  pucharOpcoes() async {
    listaNivelFormacao = await Repository.buscarNiveisDeFormacao();
    listaCursos = await Repository.buscarCursos();
    notifyListeners();
  }

  selecionarFormacao(String? value) {
    formacaoSelecionada = value;
    notifyListeners();
  }

  selecionarCurso(String? value) {
    cursoSelecionado = value;
    notifyListeners();
  }

  selecionarAno(String? value) {
    anoSelecionado = value;
    notifyListeners();
  }

  selecionarTurma(String? value) {
    turmaSelecionada = value;
    notifyListeners();
  }

  void setTurmas(List<Turma> turmas) {
    listaTurmas = turmas;
    notifyListeners();
  }

  void resetarTudo() {
    formacaoSelecionada = null;
    cursoSelecionado = null;
    anoSelecionado = null;
    turmaSelecionada = null;
    notifyListeners();
  }
}
