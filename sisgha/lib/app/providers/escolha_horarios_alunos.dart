// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/model/Turmas.dart';
import 'package:sisgha/app/domain/model/cursos.dart';
import 'package:sisgha/app/domain/model/nivel_formacao.dart';

class EscolhaHorariosAlunos extends ChangeNotifier {
  String? formacaoSelecionada;
  String? cursoSelecionado;
  String? anoSelecionado;
  String? turmaSelecionada;

  List<OfertaFormacao> listaNivelFormacao = [];
  List<Cursos> listaCursos = [];
  List<String> listaAnos = ["1° Ano", "2° Ano", "3° Ano"];
  List<Turma> listaTurmas = [];

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
