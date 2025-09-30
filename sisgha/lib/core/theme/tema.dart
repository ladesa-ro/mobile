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

      //cores componentes
      primaryContainer: CoresClaras.verdePrincipal,
      secondaryContainer: CoresClaras.verdeClaro,

      //textos
      primary: CoresClaras.textoPrincipal,
      secondary: CoresClaras.textoSecundario,
      onPrimary: CoresClaras.textoVerde,
      onSecondary: CoresClaras.textoErro,

      //bordas
      tertiary: CoresClaras.cinzaBorda,
      tertiaryContainer: CoresClaras.verdeBorda,
      onTertiary: CoresClaras.brancoBorda,

      //botões
      outline: CoresClaras.verdeBotao,
      errorContainer: CoresClaras.vermelhoBotao,
      outlineVariant: CoresClaras.botaoSecundario,

      //icones
      surfaceDim: CoresClaras.iconeBranco,
      surfaceTint: CoresClaras.iconeCinza,
      onSurfaceVariant: CoresClaras.iconeVerde,
    ),
  );

  //tema escuro
  static final temaEscuro = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,

      //fundo
      surface: CoresEscuras.background,

      //cores componentes
      primaryContainer: CoresEscuras.verdePrincipal,
      secondaryContainer: CoresEscuras.verdeClaro,

      //textos
      primary: CoresEscuras.textoPrincipal,
      secondary: CoresEscuras.textoSecundario,
      onPrimary: CoresEscuras.textoVerde,
      onSecondary: CoresEscuras.textoErro,

      //bordas
      tertiary: CoresEscuras.cinzaBorda,
      tertiaryContainer: CoresEscuras.verdeBorda,
      onTertiary: CoresEscuras.brancoBorda,

      //botões
      outline: CoresEscuras.verdeBotao,
      errorContainer: CoresEscuras.vermelhoBotao,
      outlineVariant: CoresEscuras.botaoSecundario,

      //icones
      surfaceDim: CoresEscuras.iconeBranco,
      surfaceTint: CoresEscuras.iconeCinza,
      onSurfaceVariant: CoresEscuras.iconeVerde,
    ),
  );
}
