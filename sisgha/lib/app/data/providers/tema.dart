import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';

class Temas {
  //claro
  static final temaClaro = ThemeData(
    brightness: Brightness.light,
    primaryColor: CoresClaras.verdePrincipal,
    fontFamily: 'Poppins',
    useMaterial3: true,
    bottomAppBarTheme: BottomAppBarTheme(color: CoresClaras.verdePrincipal),
    appBarTheme: AppBarTheme(
        color: CoresClaras.verdePrincipal,
        foregroundColor: CoresClaras.brancoTexto),
    colorScheme: ColorScheme.light(
      primary: CoresClaras.verdePrincipal,
      secondary: CoresClaras.verdeClaro,
    ),
  );

  //tema escuro
  static final ThemeData temaEscuro = ThemeData(
    brightness: Brightness.dark,
    primaryColor: CoresEscuras.verdePrincipalEscuro,
    fontFamily: 'Poppins',
    useMaterial3: true,
    bottomAppBarTheme:
        BottomAppBarTheme(color: CoresEscuras.verdePrincipalEscuro),
    appBarTheme: AppBarTheme(
        color: CoresEscuras.verdePrincipalEscuro,
        foregroundColor: CoresEscuras.pretoEscuro),
    colorScheme: ColorScheme.dark(
      primary: CoresEscuras.verdePrincipalEscuro,
      secondary: CoresEscuras.verdeClaroEscuro,
    ),
  );
}

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
        : CoresEscuras.pretoEscuro;
  }
}
