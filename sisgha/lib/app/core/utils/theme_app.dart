import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class ThemeApp {
  // ignore: non_constant_identifier_names
  static ThemeData Tema() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          color: ColorApp.VerdePrincipal,
          foregroundColor: ColorApp.BrancoTexto),
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: ColorApp.VerdePrincipal,
        seedColor: ColorApp.VerdeClaro,
      ).copyWith(surface: Colors.white),
    );
  }
}
