import 'package:flutter/material.dart';
import 'package:sisgha/core/theme/tema.dart';

class TemasProvider with ChangeNotifier {
  ThemeData _temaAtivo = Temas.temaClaro;

  ThemeData get temaAtivo => _temaAtivo;

  void mudarTema() {
    if (_temaAtivo.brightness == Brightness.light) {
      _temaAtivo = Temas.temaEscuro;
    } else {
      _temaAtivo = Temas.temaClaro;
    }
    notifyListeners();
  }
}
