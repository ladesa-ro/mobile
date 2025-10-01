import 'package:flutter/material.dart';

import '../utils/cores.dart';

class Temas {
  //claro
  static final temaClaro = ThemeData(
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,

        //fundo
        surface: CoresClaras.background,
        surfaceVariant: CoresClaras.verdeFraco,

        //cores componentes e botões
        primaryContainer: CoresClaras.verde,
        secondaryContainer: CoresClaras.verdeClaro,
        tertiaryContainer: CoresClaras.cinza,
        errorContainer: CoresClaras.vermelho,

        //textos
        primary: CoresClaras.textoPrincipal,
        secondary: CoresClaras.textoVerde,
        tertiary: CoresClaras.textoCinza,
        inversePrimary: CoresClaras.textoBranco,
        error: CoresClaras.textoErro,

        //borda
        onPrimary: CoresClaras.verdeBorda,
        onSecondary: CoresClaras.cinzaBorda,
        onTertiary: CoresClaras.bordaSecundaria,

        //icones
        primaryFixed: CoresClaras.iconeBranco,
        secondaryFixed: CoresClaras.iconeVerde,
        tertiaryFixed: CoresClaras.iconeCinza,
      ));

  //tema escuro
  static final temaEscuro = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,

      //fundo
      surface: CoresEscuras.background,
      surfaceVariant: CoresEscuras.verdeFraco,

      //cores componentes e botões
      primaryContainer: CoresEscuras.verde,
      secondaryContainer: CoresEscuras.verdeClaro,
      tertiaryContainer: CoresEscuras.cinza,
      errorContainer: CoresEscuras.vermelho,

      //textos
      primary: CoresEscuras.textoPrincipal,
      secondary: CoresEscuras.textoVerde,
      tertiary: CoresEscuras.textoCinza,
      inversePrimary: CoresEscuras.textoBranco,
      error: CoresEscuras.textoErro,

      //borda
      onPrimary: CoresEscuras.verdeBorda,
      onSecondary: CoresEscuras.cinzaBorda,
      onTertiary: CoresEscuras.bordaSecundaria,

      //icones
      primaryFixed: CoresEscuras.iconeBranco,
      secondaryFixed: CoresEscuras.iconeVerde,
      tertiaryFixed: CoresEscuras.iconeCinza,
    ),
  );
}
