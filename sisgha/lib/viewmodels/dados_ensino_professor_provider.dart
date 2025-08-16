import 'package:flutter/material.dart';
import 'package:sisgha/domain/model/dados_ensino.dart';
import 'package:sisgha/repository/repository.dart';

class DadosEnsinoProfessorProvider with ChangeNotifier {
  List<DadosEnsino> _dadosEnsino = [];

  Future<void> carregarDados() async {
    _dadosEnsino.clear();
    _dadosEnsino.addAll(await Repository.buscarEnsinoProfessor());

    print(_dadosEnsino[0].disciplina.nome);
    print('chegou por aqui');

    notifyListeners();
  }
}
