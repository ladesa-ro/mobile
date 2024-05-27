import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';

class ThemeApp {
  // ignore: non_constant_identifier_names
  static ThemeData Tema() {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.transparent),
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: ColorApp.VerdePrincipal,
        seedColor: ColorApp.VerdeClaro,
        // o flutter atualizou e substituiu o backgraud para o surface
      ).copyWith(surface: Colors.white),
    );
  }
}
