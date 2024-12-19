import 'package:flutter/material.dart';

class EscolhaCalendario with ChangeNotifier {
  final List<String> _anos = ['2022', '2023', '2024'];
  final List<String> _cursos = [
    'Informática 2024',
    'Química 2024',
    'Floresta 2024',
  ];
  final List<String> _modalidades = [
    'Graduação',
    'Técnico Integrado',
    'Técnico Subsequente',
    'Técnico Concomitante',
  ];
  int _anoSelecionado = 0;
  int _cursoSelecionado = 0;
  int _modalidadeSelecionada = 0;

  List<String> get anos => _anos;
  List<String> get cursos => _cursos;
  List<String> get modalidades => _modalidades;
  int get anoSelecionado => _anoSelecionado;
  int get cursoSelecionado => _cursoSelecionado;
  int get modalidadeSelecionada => _modalidadeSelecionada;

  void alterarAnoSelecionado(int index) {
    _anoSelecionado = index;
    notifyListeners();
  }

  void alterarCursoSelecionado(int index) {
    _cursoSelecionado = index;
    notifyListeners();
  }

  void alterarModalidadeSelecionada(int index) {
    _modalidadeSelecionada = index;
    notifyListeners();
  }
}
