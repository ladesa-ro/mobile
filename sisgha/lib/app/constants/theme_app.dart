import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';

class ThemeApp {
  static ThemeData Tema() {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.transparent),
      fontFamily: 'Poppins',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: ColorApp.VerdeEscuro,
        seedColor: ColorApp.VerdeClaro,
      ).copyWith(background: Colors.white),
    );
  }
}
