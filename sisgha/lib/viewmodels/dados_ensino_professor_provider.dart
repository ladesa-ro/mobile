import 'package:flutter/material.dart';
import 'package:sisgha/domain/model/dados_ensino.dart';
import 'package:sisgha/repository/repository.dart';

class DadosEnsinoProfessorProvider with ChangeNotifier {
  final List<DadosEnsino> _dadosEnsino = [];

  List<DadosEnsino> get dadosEnsino => _dadosEnsino;

  Future<void> carregarDados() async {
    _dadosEnsino.clear();
    _dadosEnsino.addAll(await Repository.buscarEnsinoProfessor());
    notifyListeners();
  }
}
