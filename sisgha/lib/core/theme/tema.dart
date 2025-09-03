import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Temas {
  //claro
  static final temaClaro = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: CoresClaras.pretoTexto,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: CoresClaras.verdePrincipal,
    fontFamily: 'Poppins',
    useMaterial3: true,
    bottomAppBarTheme: BottomAppBarThemeData(color: CoresClaras.verdePrincipal),
    appBarTheme: AppBarTheme(
        color: CoresClaras.verdePrincipal,
        foregroundColor: CoresClaras.brancoTexto),
    colorScheme: ColorScheme.light(
        primary: CoresClaras.verdePrincipal,
        onPrimary: CoresClaras.cinzatexto,
        secondary: CoresClaras.verdeClaro,
        surfaceVariant: CoresClaras.branco,
        surface: CoresClaras.corDeFundoClara),
  );

  //tema escuro
  static final ThemeData temaEscuro = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: CoresEscuras.brancoTextoEscuro,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    brightness: Brightness.dark,
    primaryColor: CoresEscuras.verdePrincipalEscuro,
    fontFamily: 'Poppins',
    useMaterial3: true,
    bottomAppBarTheme:
        BottomAppBarThemeData(color: CoresEscuras.verdePrincipalEscuro),
    appBarTheme: AppBarTheme(
        color: CoresEscuras.verdePrincipalEscuro,
        foregroundColor: CoresEscuras.brancoTextoEscuro),
    colorScheme: ColorScheme.dark(
      primary: CoresEscuras.verdePrincipalEscuro,
      onPrimary: CoresEscuras.cinzaTextoEscuro,
      secondary: CoresEscuras.verdeClaroEscuro,
      surfaceVariant: Colors.transparent,
      surface: CoresEscuras.pretoEscuro,
    ),
  );
}
