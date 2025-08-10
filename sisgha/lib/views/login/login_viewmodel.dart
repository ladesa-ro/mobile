// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';

import '../../repository/repository.dart';

class LoginViewModel extends ChangeNotifier {
  bool senhaVisivel = false;

  void alternarVisibilidadeSenha() {
    senhaVisivel = !senhaVisivel;
    notifyListeners();
  }

  Future<bool?> verificarLogin(
      TextEditingController matricula, TextEditingController senha) async {
    try {
      final deuCerto = await Repository.login(matricula, senha)
          .timeout(const Duration(seconds: 7));
      return deuCerto;
    } on TimeoutException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
