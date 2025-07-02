import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/domain/api/repository.dart';
import 'package:sisgha/app/domain/model/turmas.dart';
import 'package:sisgha/app/domain/model/cursos.dart';
import 'package:sisgha/app/domain/model/nivel_formacao.dart';

class EscolhaHorariosAlunos extends ChangeNotifier {
  String? nomeFormacaoSelecionada;
  String? idFormacaoSelecionada;
  String? cursoSelecionado;
  String? turmaSelecionada;

  List<OfertaFormacao> listaNivelFormacao = [];
  List<Cursos> listaCursos = [];
  List<Turma> listaTurmas = [];

  bool cursoExpandido = false;
  bool turmaExpandida = false;

  void expandirCurso(bool value) {
    cursoExpandido = value;
    notifyListeners();
  }

  void expandirTurma(bool value) {
    turmaExpandida = value;
    notifyListeners();
  }

  pucharOpcoes() async {
    listaNivelFormacao = await Repository.buscarNiveisDeFormacao();
    notifyListeners();
  }

  Future<void> selecionarFormacao(String? value) async {
    if (value == null || value == '') {
      idFormacaoSelecionada = null;
      nomeFormacaoSelecionada = null;
      cursoSelecionado = null;
      turmaSelecionada = null;
      listaCursos.clear();
      listaTurmas.clear();
      cursoExpandido = false;
      turmaExpandida = false;
    } else {
      final buscaRelacionados = listaNivelFormacao
          .firstWhere((e) => e.ofertaFormacao['nome'] == value);

      idFormacaoSelecionada = buscaRelacionados.ofertaFormacao['id'];

      nomeFormacaoSelecionada = value;
      listaCursos = await Repository.buscarCursos(
          ofertaFormacaoId: idFormacaoSelecionada!);
      cursoExpandido = true;
      turmaExpandida = false;
      listaTurmas.clear();
      cursoSelecionado = null;
      turmaSelecionada = null;
    }

    notifyListeners();
  }

  selecionarCurso(String? value) async {
    if (value == null || value == '') {
      cursoSelecionado = null;
      turmaSelecionada = null;
      listaTurmas.clear();
      turmaExpandida = false;
    } else {
      cursoSelecionado = value;
      listaTurmas = await Repository.buscarTurmas(nomeCurso: cursoSelecionado!);
      turmaExpandida = true;
      turmaSelecionada = null;
    }

    notifyListeners();
  }

  selecionarTurma(String? value) {
    if (value == null || value == '') {
      turmaSelecionada = null;
    } else {
      turmaSelecionada = value;
    }
    notifyListeners();
  }

  void setTurmas(List<Turma> turmas) {
    listaTurmas = turmas;
    notifyListeners();
  }

  void resetarTudo() {
    idFormacaoSelecionada = null;
    nomeFormacaoSelecionada = null;
    cursoSelecionado = null;
    turmaSelecionada = null;
    listaCursos.clear();
    listaTurmas.clear();
    cursoExpandido = false;
    turmaExpandida = false;
    notifyListeners();
  }
}
