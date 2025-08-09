import 'package:flutter/material.dart';
import 'package:sisgha/core/theme/tema.dart';

import '../utils/colors.dart';

class TemasProvider with ChangeNotifier {
  ThemeData _temaAtivo = Temas.temaClaro;

  ThemeData get temaAtivo => _temaAtivo;

  void muldarTema() {
    if (_temaAtivo.brightness == Brightness.light) {
      _temaAtivo = Temas.temaEscuro;
    } else {
      _temaAtivo = Temas.temaClaro;
    }
    notifyListeners();
  }

  Color corDosIcones() {
    return _temaAtivo.brightness == Brightness.light
        ? CoresClaras.branco
        : CoresEscuras.brancoBotaoEscuro;
  }
}
