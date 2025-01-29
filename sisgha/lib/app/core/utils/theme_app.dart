import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class ThemeApp {
  static ThemeData tema() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          color: ColorApp.verdePrincipal,
          foregroundColor: ColorApp.brancoTexto),
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: ColorApp.verdePrincipal,
        seedColor: ColorApp.verdeClaro,
      ).copyWith(surface: Colors.white),
    );
  }
}
