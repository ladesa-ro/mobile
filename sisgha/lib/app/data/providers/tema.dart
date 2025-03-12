import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';

class Temas {
  //claro
  static final temaClaro = ThemeData(
    // textTheme:
    //     TextTheme(bodyLarge: TextStyle(color: CoresClaras.brancoTexto)), codigo que mulda a cor dos textos
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
    // textTheme:
    //     TextTheme(bodyLarge: TextStyle(color: CoresEscuras.brancoTextoEscuro)), codigo que mulda a cor dos textos
    brightness: Brightness.dark,
    primaryColor: CoresEscuras.verdePrincipalEscuro,
    fontFamily: 'Poppins',
    useMaterial3: true,
    bottomAppBarTheme:
        BottomAppBarTheme(color: CoresEscuras.verdePrincipalEscuro),
    appBarTheme: AppBarTheme(
        color: CoresEscuras.verdePrincipalEscuro,
        foregroundColor: CoresEscuras.brancoTextoEscuro),
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
