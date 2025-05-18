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

  pucharOpcoes() async {
    listaNivelFormacao = await Repository.buscarNiveisDeFormacao();
    notifyListeners();
  }

  void selecionarFormacao(String? value) async {
    final buscaRelacionados = listaNivelFormacao.firstWhere(
      (e) => e.ofertaFormacao['nome'] == value,
    );

    idFormacaoSelecionada = buscaRelacionados.ofertaFormacao['id'];

    nomeFormacaoSelecionada = value;
    listaCursos = await Repository.buscarCursos(
        ofertaFormacaoId: idFormacaoSelecionada ?? '');

    notifyListeners();
  }

  selecionarCurso(String? value) async {
    cursoSelecionado = value;
    listaTurmas =
        await Repository.buscarTurmas(nomeCurso: cursoSelecionado ?? '');
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
    idFormacaoSelecionada = null;
    cursoSelecionado = null;
    turmaSelecionada = null;
    notifyListeners();
  }
}
