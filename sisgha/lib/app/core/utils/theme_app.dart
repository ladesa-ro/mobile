import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class ThemeApp {
  static ThemeData tema() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          color: ColorsTemaClaro.verdePrincipal,
          foregroundColor: ColorsTemaClaro.brancoTexto),
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: ColorsTemaClaro.verdePrincipal,
        seedColor: ColorsTemaClaro.verdeClaro,
      ).copyWith(surface: Colors.white),
    );
  }
}
