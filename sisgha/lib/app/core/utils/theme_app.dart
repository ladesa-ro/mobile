import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class ThemeApp {
  static ThemeData tema() {
    return ThemeData(
      bottomAppBarTheme: BottomAppBarTheme(color: CoresClaras.verdePrincipal),
      appBarTheme: AppBarTheme(
          color: CoresClaras.verdePrincipal,
          foregroundColor: CoresClaras.brancoTexto),
      fontFamily: 'Poppins',
      useMaterial3: true,
    );
  }
}
