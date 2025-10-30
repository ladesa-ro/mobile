import 'package:flutter/material.dart';

class TemasProvider with ChangeNotifier {
  ThemeMode? themeMode;

  void carregarTemaSalvo(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }

  void mudarTema(bool? ativo) {
    if (ativo == null) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = ativo ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }
}
